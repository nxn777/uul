import 'package:UUL_Gym/models/appartment.dart';
import 'package:UUL_Gym/models/floor.dart';
import 'package:UUL_Gym/models/door_number.dart';
import 'package:UUL_Gym/models/tower.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/screens/newprofile/stepper/step_operations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const int _FIRST_STEP = 0;

class NewProfileViewModel extends ChangeNotifier {
  final Function(User) onUserCreated;

  NewProfileViewModel({@required this.onUserCreated});

  int _totalSteps = 0;
  int _currentStep = _FIRST_STEP;

  int get currentStep => _currentStep;

  set totalSteps(int value) {
    _totalSteps = value;
  }

  String name = "";
  String pwd = "";
  final Map<int, NewProfileStepValidator> _validators = {};
  final Map<int, NewProfileStepEraser> _erasers = {};
  final Map<int, NewProfileStepEnabler> _enablers = {};

  final Set<int> _visited = {_FIRST_STEP};
  final accountFormKey = GlobalKey<FormState>();


  final List<Tower> towers = Tower.getTowers();
  int activeTowerId = -1;
  Tower get activeTower => activeTowerId == -1 ? null : towers[activeTowerId];

  List<Floor> get floors => activeTower == null ? [] : Floor.getFloors(activeTower);
  int activeFloorId = -1;

  final List<Door> doors = Door.getDoor();
  int activeDoorId = -1;

  String activeAvatarImage;

  StepState getStepState(int index) {
    if (index == _currentStep) {
      return StepState.editing;
    }
    if (_visited.contains(index)) {
      if (!_validators[index].call(this)) {
        return StepState.error;
      } else {
        return StepState.complete;
      }
    }
    return StepState.indexed;
  }

  bool isStepActive(int index) => _enablers[index].call(this);

  int _getNextActiveStep(int start) {
    int i = start;
    while (i < _totalSteps -1) {
      i++;
      if (isStepActive(i)) {
        return i;
      }
    }
    return start;
  }

  String getNextButtonTitle() {
    if (_currentStep == _totalSteps - 1) {
      return "Create";
    }
    return "Next";
  }

  String getClearButtonTitle() {
    if (_currentStep == _totalSteps - 1) {
      return "Reset all";
    }
    return "Clear";
  }

  bool nextButtonIsEnabled() => (_currentStep != _totalSteps -1) || isComplete();

  String getAppartmentName() {
    if (activeTower == null || activeFloorId == -1 || activeDoorId == -1) {
      return null;
    }
    return "${activeTower.getTitle()}${floors[activeFloorId].getTitle(raw: true)}${doors[activeDoorId].getTitle()}";
  }

  void gotoStep(int newStep) {
    if (!isStepActive(newStep)) { return; }
    if (newStep < _totalSteps && newStep >= 0) {
      _currentStep = newStep;
      _visited.add(_currentStep);
    }
    notifyListeners();
  }

  void nextStep() {
    if (isComplete()) {
      _onComplete();
      return;
    }
    gotoStep(_getNextActiveStep(_currentStep));
  }

  void clearStep() {
    _erasers[_currentStep].call(this);
    _visited.remove(_currentStep);
    notifyListeners();
  }

  void registerValidator(int step, NewProfileStepValidator validator) => _validators[step] = validator;

  void registerEraser(int step, NewProfileStepEraser eraser) => _erasers[step] = eraser;

  void registerEnabler(int step, NewProfileStepEnabler enabler) => _enablers[step] = enabler;

  bool isComplete() => (_currentStep == _totalSteps - 1) && _visited.length == _totalSteps && _allValid();

  void _onComplete() {
    User user = User(name: name, appartment: Appartment(code: getAppartmentName()), avatarImageSrc: activeAvatarImage);
    this.onUserCreated(user);
  }

  bool _allValid() => !_validators.values.any((validator) => !validator.call(this));

  void changeActiveTower(Tower tower) {
    if (tower == null) {
      this.activeTowerId = -1;
    } else {
      this.activeTowerId = tower.id;
    }
    this.activeFloorId = -1;
    notifyListeners();
  }

  void changeActiveFloor(Floor floor) {
    if (floor == null) {
      this.activeFloorId = -1;
    } else {
      this.activeFloorId = floor.id;
    }
    notifyListeners();
  }

  void changeActiveDoor(Door door) {
    if (door == null) {
      this.activeDoorId = -1;
    } else {
      this.activeDoorId = door.id;
    }
    notifyListeners();
  }

  void changeActiveAvatarImage(String image) {
    this.activeAvatarImage = image;
    notifyListeners();
  }

  void eraseAll({Set<int> exceptSet}) {
    _erasers.forEach((index, eraser) {
      if (!exceptSet.contains(index)) {
        eraser.call(this);
      }
      _visited.remove(index);
    });
    gotoStep(_FIRST_STEP);
  }
}

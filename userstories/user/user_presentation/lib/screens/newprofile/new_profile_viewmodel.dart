import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rules_api/rules_api.dart';
import 'package:user_api/user_api.dart';

import 'new_profile_screen_object.dart';
import 'stepper/step_operations.dart';

const int _FIRST_STEP = 0;

// TODO use erasers on dependent fields when changing address parts
class NewProfileViewModel extends ChangeNotifier with ViewStateField<NewProfileScreenObject> {
  final UserRepo _userRepo;
  final RulesRepo _rulesRepo;
  final Function(User) onUserCreated;
  Condo _condo;

  NewProfileViewModel(this._userRepo, this._rulesRepo, {@required this.onUserCreated}) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

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

  List<String> get towers => _condo.towers;
  String activeTower = "";

  List<String> get floors => _condo.getFloors(activeTower);
  String activeFloor = "";

  List<String> get doors => _condo.getDoors(activeTower, activeFloor);
  String activeDoor = "";

  String activeAvatarImage;

  void fetchData() async {
    (await _rulesRepo.loadRules()).fold(onSuccess: (rules) {
      _condo = Condo(rules.buildings, rules.specialFloorTitles, rules.doorsPerFloor, rules.bannedApartments);
      viewState = ViewState(value: NewProfileScreenObject(), status: ViewStatus.IDLE);
      notifyListeners();
    }, onFailure: (response) {
      print(this.toString() + ":" + response.message);
    });
  }

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
    while (i < _totalSteps - 1) {
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

  String getApartmentCode() => _condo.getApartmentCode(activeTower, activeFloor, activeDoor);

  bool nextButtonIsEnabled() => (_currentStep != _totalSteps - 1) || isComplete();

  void gotoStep(int newStep) {
    if (!isStepActive(newStep)) {
      return;
    }
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

  void _onComplete() async {
    User user = User(name: name, pwdHash: pwd, apartmentCode: getApartmentCode(), avatarImageSrc: activeAvatarImage);
    await this._userRepo.addUser(user);
    this.onUserCreated(user);
  }

  bool _allValid() => !_validators.values.any((validator) => !validator.call(this));

  void changeActiveTower(String tower) {
    this.activeTower = tower;
    this.activeFloor = "";
    notifyListeners();
  }

  void changeActiveFloor(String floor) {
    this.activeFloor = floor;
    this.activeDoor = "";
    notifyListeners();
  }

  void changeActiveDoor(String door) {
    this.activeDoor = door;
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

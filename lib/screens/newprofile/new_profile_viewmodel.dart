import 'package:UUL_Gym/models/floor.dart';
import 'package:UUL_Gym/models/door_number.dart';
import 'package:UUL_Gym/models/tower.dart';
import 'package:UUL_Gym/screens/newprofile/stepper/step_operations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const int _FIRST_STEP = 0;

class NewProfileViewModel extends ChangeNotifier {
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
  final Set<int> _visited = {_FIRST_STEP};
  final accountFormKey = GlobalKey<FormState>();


  final List<Tower> towers = Tower.getTowers();
  int activeTowerId = 0;
  Tower get activeTower => towers[activeTowerId];

  List<Floor> get floors => Floor.getFloors(activeTower);
  int activeFloorId = 0;
  Floor get activeFloor => floors[activeTowerId];

  final List<Door> doors = Door.getDoor();
  int activeDoorId = 0;
  Door get activeDoor => doors[activeDoorId];
  
  StepState getStepState(int index) {
    if (index == _currentStep) {
      return StepState.editing;
    }
    if (!_validators[index].call(this)) {
      return StepState.error;
    } else if (_visited.contains(index)) {
      return StepState.complete;
    }
    return StepState.indexed;
  }

  bool isStepActive(int index) {
    // if (_visited.contains(index) && _currentStep != index) {
    //   return false;
    // }
    return true;
  }

  void gotoStep(int newStep) {
    if (newStep < _totalSteps && newStep >= 0) {
      _currentStep = newStep;
      _visited.add(_currentStep);
    }
    notifyListeners();
  }

  void nextStep() {
    if (_isComplete()) {
      _onComplete();
      return;
    }
    if (_validators[_currentStep].call(this) == true) {
      gotoStep(_currentStep + 1);
    }
  }

  void clearStep() {
    _erasers[_currentStep].call(this);
    _visited.remove(_currentStep);
    notifyListeners();//gotoStep(_currentStep - 1);
  }

  void registerValidator(int step, NewProfileStepValidator validator) {
    _validators[step] = validator;
  }

  void registerEraser(int step, NewProfileStepEraser eraser) {
    _erasers[step] = eraser;
  }

  bool _isComplete() {
    return (_currentStep == _totalSteps - 1) && _allValid();
  }

  void _onComplete() {
    print("complete!");
  }

  bool _allValid() {
    _validators.forEach((_, validator) {
      if (!validator.call(this)) {
        return false;
      }
    });
    return true;
  }

  void changeActiveTower(Tower tower) {
    if (tower == null) {
      this.activeTowerId = 0;
    } else {
      this.activeTowerId = tower.id;
    }
    this.activeFloorId = 0;
    notifyListeners();
  }

  void changeActiveFloor(Floor floor) {
    if (floor == null) {
      this.activeFloorId = 0;
    } else {
      this.activeFloorId = floor.id;
    }
    notifyListeners();
  }

  void changeActiveDoor(Door door) {
    if (door == null) {
      this.activeDoorId = 0;
    } else {
      this.activeDoorId = door.id;
    }
    notifyListeners();
  }
}

import 'package:UUL_Gym/screens/newprofile/stepper/step_operations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _FIRST_STEP = 0;
class NewProfileViewModel extends ChangeNotifier {
  int _totalSteps = 0;
  int _currentStep = _FIRST_STEP;
  set totalSteps(int value) {
    _totalSteps = value;
  }

  final Map<int, NewProfileStepValidator> _validators = {};
  final Map<int, NewProfileStepEraser> _erasers = {};
  final Set<int> _visited = {_FIRST_STEP};


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
    return true;
  }

  void gotoStep(int index) {
    if (_currentStep + 1 <= _totalSteps && _currentStep > 0) {
      _currentStep = index;
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

  void cancelStep() {
    _erasers[_currentStep].call(this);
    _visited.remove(_currentStep);
    gotoStep(_currentStep - 1);
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
}

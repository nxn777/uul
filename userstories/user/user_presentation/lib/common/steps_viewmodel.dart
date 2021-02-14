import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'step_operations.dart';

abstract class StepsViewModel extends ChangeNotifier {
  StepsViewModel(this.kFirstStep) {
    visited.add(this.kFirstStep);
    _currentStep = kFirstStep;
  }

  final int kFirstStep;
  final Map<int, StepValidator> validators = {};
  final Map<int, StepEraser> erasers = {};
  final Map<int, StepEnabler> enablers = {};
  final Set<int> visited = {};
  int _totalSteps = 0;
  int _currentStep;
  int get currentStep => _currentStep;

  void onTotalStepsChange(int newTotal) {}
  set totalSteps(int value) {
    _totalSteps = value;
    onTotalStepsChange(_totalSteps);
  }

  void registerValidator(int step, StepValidator validator) => validators[step] = validator;

  void registerEraser(int step, StepEraser eraser) => erasers[step] = eraser;

  void registerEnabler(int step, StepEnabler enabler) => enablers[step] = enabler;

  StepState getStepState(int index) {
    if (index == _currentStep) {
      return StepState.editing;
    }
    if (visited.contains(index)) {
      if (!validators[index].call(this)) {
        return StepState.error;
      } else {
        return StepState.complete;
      }
    }
    return StepState.indexed;
  }


  bool isStepActive(int index) => enablers[index].call(this);

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

  String get applyButtonTitle => "Create";
  String getNextButtonTitle() {
    if (_currentStep == _totalSteps - 1) {
      return applyButtonTitle;
    }
    return "Next";
  }

  String getClearButtonTitle() {
    if (_currentStep == _totalSteps - 1) {
      return "Reset all";
    }
    return "Clear";
  }

  bool nextButtonIsEnabled() => (_currentStep != _totalSteps - 1) || isComplete();

  void gotoStep(int newStep) {
    if (!isStepActive(newStep)) {
      return;
    }
    if (newStep < _totalSteps && newStep >= 0) {
      _currentStep = newStep;
      visited.add(_currentStep);
    }
    notifyListeners();
  }

  bool _allValid() => !validators.values.any((validator) => !validator.call(this));

  bool isComplete() => (_currentStep == _totalSteps - 1) && visited.length == _totalSteps && _allValid();

  void onComplete();

  void nextStep() {
    if (isComplete()) {
      onComplete();
      return;
    }
    gotoStep(_getNextActiveStep(_currentStep));
  }

  void clearStep() {
    erasers[_currentStep].call(this);
    visited.remove(_currentStep);
    notifyListeners();
  }

  void eraseAll({Set<int> exceptSet}) {
    erasers.forEach((index, eraser) {
      if (!exceptSet.contains(index)) {
        eraser.call(this);
      }
      visited.remove(index);
    });
    gotoStep(kFirstStep);
  }

  void markAllStepsVisited() {
    for(int i = 0; i< _totalSteps; i++) {
      visited.add(i);
    }
  }
}

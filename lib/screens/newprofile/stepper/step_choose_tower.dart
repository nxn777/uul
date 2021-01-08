
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:flutter/material.dart';

Step createChooseTowerStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  viewModel.registerValidator(index, _chooseTowerStepValidator);
  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your tower"),
    content: Container(child: Text("Here will be options"))
  );
}

bool _chooseTowerStepValidator(NewProfileViewModel viewModel) {
  return true;
}
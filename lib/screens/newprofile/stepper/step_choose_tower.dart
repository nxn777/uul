import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/tower/tower_list.dart';
import 'package:flutter/material.dart';

Step createChooseTowerStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseTowerStepValidator(NewProfileViewModel viewModel) {
    return true;
  }

  void _chooseTowerStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveTower(null);
  }

  viewModel.registerValidator(index, _chooseTowerStepValidator);
  viewModel.registerEraser(index, _chooseTowerStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your tower"),
    content: Container(
      child: TowerList(),
    ),
  );
}

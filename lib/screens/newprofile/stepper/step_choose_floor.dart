import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/floor/floor_list.dart';
import 'package:flutter/material.dart';

Step createChooseFloorStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseFloorStepValidator(NewProfileViewModel viewModel) {
    return true;
  }

  void _chooseFloorStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveFloor(null);
  }

  viewModel.registerValidator(index, _chooseFloorStepValidator);
  viewModel.registerEraser(index, _chooseFloorStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your floor"),
    content: Container(
      child: FloorList(),
    ),
  );
}

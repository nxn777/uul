import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/floor/floor_list.dart';
import 'package:flutter/material.dart';

Step createChooseFloorStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseFloorStepValidator(NewProfileViewModel viewModel) {
    return viewModel.activeFloorId != -1;
  }

  void _chooseFloorStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveFloor(null);
  }

  bool _stepEnabler(NewProfileViewModel viewModel) => !(viewModel.activeTowerId == -1);

  viewModel.registerEnabler(index, _stepEnabler);
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

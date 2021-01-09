import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/Door/Door_list.dart';
import 'package:flutter/material.dart';

Step createChooseDoorStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseDoorStepValidator(NewProfileViewModel viewModel) {
    return true;
  }

  void _chooseDoorStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveDoor(null);
  }

  viewModel.registerValidator(index, _chooseDoorStepValidator);
  viewModel.registerEraser(index, _chooseDoorStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your door"),
    content: Container(
      child: DoorList(),
    ),
  );
}

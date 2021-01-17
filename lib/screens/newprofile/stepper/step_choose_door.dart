import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/Door/Door_list.dart';
import 'package:flutter/material.dart';

Step createChooseDoorStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseDoorStepValidator(NewProfileViewModel viewModel) {
    return viewModel.activeDoorId != -1;
  }

  void _chooseDoorStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveDoor(null);
  }

  bool _stepEnabler(NewProfileViewModel viewModel) => true;
  viewModel.registerEnabler(index, _stepEnabler);
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
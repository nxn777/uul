import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import '../new_profile_viewmodel.dart';

Step createChooseFloorStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseFloorStepValidator(NewProfileViewModel viewModel) {
    return viewModel.activeFloor.isNotEmpty;
  }

  void _chooseFloorStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveFloor("");
  }

  bool _stepEnabler(NewProfileViewModel viewModel) => viewModel.activeTower.isNotEmpty;

  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _chooseFloorStepValidator);
  viewModel.registerEraser(index, _chooseFloorStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your floor"),
    content: Container(
      child: ApartmentDetailSelector(
        items: viewModel.floors,
        activeItem: viewModel.activeFloor,
        onItemTap: viewModel.changeActiveFloor,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:i18n/i18n.dart';
import '../new_profile_viewmodel.dart';

Step createChooseFloorStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseFloorStepValidator(viewModel) => (viewModel as NewProfileViewModel).activeFloor.isNotEmpty;

  void _chooseFloorStepEraser(viewModel) => (viewModel as NewProfileViewModel).changeActiveFloor("");

  bool _stepEnabler(viewModel) => (viewModel as NewProfileViewModel).activeTower.isNotEmpty;

  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _chooseFloorStepValidator);
  viewModel.registerEraser(index, _chooseFloorStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your floor".i18n),
    content: Container(
      child: ApartmentDetailSelector(
        items: viewModel.floors,
        activeItem: viewModel.activeFloor,
        onItemTap: viewModel.changeActiveFloor,
      ),
    ),
  );
}

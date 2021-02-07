import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import '../new_profile_viewmodel.dart';

Step createChooseTowerStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseTowerStepValidator(NewProfileViewModel viewModel) {
    return viewModel.activeTower.isNotEmpty;
  }

  void _chooseTowerStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveTower("");
  }

  bool _stepEnabler(NewProfileViewModel viewModel) => true;
  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _chooseTowerStepValidator);
  viewModel.registerEraser(index, _chooseTowerStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your tower"),
    content: Container(
      child: ApartmentDetailSelector(
        items: viewModel.towers,
        activeItem: viewModel.activeTower,
        onItemTap: viewModel.changeActiveTower,
      ),
    ),
  );
}

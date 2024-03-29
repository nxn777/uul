import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:i18n/i18n.dart';

import '../new_profile_viewmodel.dart';

Step createChooseDoorStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseDoorStepValidator(viewModel) => (viewModel as NewProfileViewModel).activeDoor.isNotEmpty;

  void _chooseDoorStepEraser(viewModel) => (viewModel as NewProfileViewModel).changeActiveDoor("");

  bool _stepEnabler( viewModel) => true;

  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _chooseDoorStepValidator);
  viewModel.registerEraser(index, _chooseDoorStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your door".i18n),
    content: Container(
      child: ApartmentDetailSelector(
        items: viewModel.doors,
        activeItem: viewModel.activeDoor,
        onItemTap: viewModel.changeActiveDoor,
      ),
    ),
  );
}

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import '../new_profile_viewmodel.dart';

Step createChooseAvatarStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseAvatarStepValidator(NewProfileViewModel viewModel) {
    return viewModel.activeAvatarImage != null;
  }

  void _chooseAvatarStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveAvatarImage(null);
  }

  bool _stepEnabler(NewProfileViewModel viewModel) => true;
  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _chooseAvatarStepValidator);
  viewModel.registerEraser(index, _chooseAvatarStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your avatar"),
    content: Column(
      children: [
        BundledAvatar(
          height: kSpacingHuge * 2,
          imageSrc: viewModel.activeAvatarImage,
        ),
        BundledAvatarsList(
          height: kSpacingHuge,
          onTap: (image) {
            viewModel.changeActiveAvatarImage(image);
          },
        ),
      ],
    ),
  );
}

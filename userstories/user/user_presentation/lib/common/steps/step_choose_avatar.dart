import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/common/profile_mixins.dart';
import 'package:user_presentation/common/steps_viewmodel.dart';
import 'package:widgets/widgets.dart';


Step createChooseAvatarStep(BuildContext context, int index, StepsViewModel viewModel) {
  bool _chooseAvatarStepValidator(viewModel) => (viewModel as AvatarSelection).activeAvatarImage != null;

  void _chooseAvatarStepEraser(viewModel) => (viewModel as AvatarSelection).changeActiveAvatarImage(null);

  bool _stepEnabler(viewModel) => true;
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
          imageSrc: (viewModel as AvatarSelection).activeAvatarImage,
        ),
        BundledAvatarsList(
          height: kSpacingHuge,
          onTap: (image) {
            (viewModel as AvatarSelection).changeActiveAvatarImage(image);
          },
        ),
      ],
    ),
  );
}

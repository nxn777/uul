import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatar.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatars_list.dart';
import 'package:flutter/material.dart';

Step createChooseAvatarStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseAvatarStepValidator(NewProfileViewModel viewModel) {
    return viewModel.activeAvatarImage != null;
  }

  void _chooseAvatarStepEraser(NewProfileViewModel viewModel) {
    viewModel.changeActiveAvatarImage(null);
  }

  viewModel.registerValidator(index, _chooseAvatarStepValidator);
  viewModel.registerEraser(index, _chooseAvatarStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your avatar"),
    content: Column(
      children: [
        BundledAvatar(height: kSpacingHuge * 2, imageSrc: viewModel.activeAvatarImage,),
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

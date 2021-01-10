import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/Door/Door_list.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatars_list.dart';
import 'package:flutter/material.dart';

Step createChooseAvatarStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseAvatarStepValidator(NewProfileViewModel viewModel) {
    return true;
  }

  void _chooseAvatarStepEraser(NewProfileViewModel viewModel) {
    //viewModel.changeActiveDoor(null);
  }

  viewModel.registerValidator(index, _chooseAvatarStepValidator);
  viewModel.registerEraser(index, _chooseAvatarStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Choose your avatar"),
    content: BundledAvatarsList(
      height: kSpacingHuge,
      onTap: (image) {
        print(image);
      },
    ),
  );
}

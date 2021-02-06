import 'package:common/common.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatar.dart';
import 'package:UUL_Gym/widgets/user/short_user_info.dart';
import 'package:flutter/material.dart';

Step createReviewStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  bool _chooseReviewStepValidator(NewProfileViewModel viewModel) {
    return viewModel.activeAvatarImage != null;
  }

  void _chooseReviewStepEraser(NewProfileViewModel viewModel) {
    // clear all and goto 1
    viewModel.changeActiveAvatarImage(null);
    viewModel.eraseAll(exceptSet: {index});
  }

  bool _stepEnabler(NewProfileViewModel viewModel) => true;
  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _chooseReviewStepValidator);
  viewModel.registerEraser(index, _chooseReviewStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Review and create"),
    content: Column(
      children: [
        Row(
          children: [
            BundledAvatar(
              height: kSpacingHuge * 1.5,
              imageSrc: viewModel.activeAvatarImage,
            ),
            SizedBox(
              width: kSpacingMedium,
            ),
            ShortUserInfo(
              name: viewModel.name,
              apartmentCode: viewModel.getApartmentCode(),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, kSpacingMedium, 0, 0),
          child: Text(
            "Your profile will be saved on a server, you will need to visit Uno Urban Life administration in person to activate it.\nPlease remember your user name.",
            style: kRegularActiveTextStyle,
          ),
        )
      ],
    ),
  );
}

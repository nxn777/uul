import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/common/steps_viewmodel.dart';
import 'package:widgets/widgets.dart';

import '../profile_mixins.dart';

Step createReviewStep(BuildContext context, int index, StepsViewModel viewModel) {
  bool _chooseReviewStepValidator(viewModel) => (viewModel as AvatarSelection).activeAvatarImage != null;

  void _chooseReviewStepEraser(viewModel) {
    // clear all and goto 1
    (viewModel as AvatarSelection).changeActiveAvatarImage(null);
    (viewModel as StepsViewModel).eraseAll(exceptSet: {index});
  }

  bool _stepEnabler(viewModel) => true;
  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _chooseReviewStepValidator);
  viewModel.registerEraser(index, _chooseReviewStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text((viewModel as HasReviewInfo).reviewInfo.reviewStepTitle),
    content: Column(
      children: [
        Row(
          children: [
            BundledAvatar(
              height: kSpacingHuge * 1.5,
              imageSrc: (viewModel as AvatarSelection).activeAvatarImage,
            ),
            SizedBox(
              width: kSpacingMedium,
            ),
            ShortUserInfo(
              name: (viewModel as HasReviewInfo).reviewInfo.name,
              apartmentCode: (viewModel as HasReviewInfo).reviewInfo.apartmentCode,
              login: (viewModel as HasReviewInfo).reviewInfo.login,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, kSpacingMedium, 0, 0),
          child: Text(
            "Your profile will be saved on a server, you will need to visit Uno Urban Life administration in person to activate it.\nPlease remember your login and name.",
            style: kRegularActiveTextStyle,
          ),
        )
      ],
    ),
  );
}

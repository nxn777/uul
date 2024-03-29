import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../new_profile_viewmodel.dart';
import '../../../common/steps/step_choose_avatar.dart';
import '../../../common/steps/step_choose_review.dart';
import 'step_choose_door.dart';
import 'step_choose_floor.dart';
import 'step_choose_tower.dart';
import 'step_new_account.dart';

class NewProfileStepsFactory {
  List<Step> getNewProfileSteps(BuildContext context, NewProfileViewModel viewModel) {
    var list = [
      createNewAccountStep,
      createChooseTowerStep,
      createChooseFloorStep,
      createChooseDoorStep,
      createChooseAvatarStep,
      createReviewStep,
    ];
    viewModel.totalSteps = list.length;
    return list.mapIndexed((value, index) => value.call(context, index, viewModel));
  }
}

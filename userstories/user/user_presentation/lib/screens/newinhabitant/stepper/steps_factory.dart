import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/screens/newinhabitant/stepper/step_new_inhabitant.dart';

import '../new_inhabitant_viewmodel.dart';
import '../../../common/steps/step_choose_avatar.dart';
import '../../../common/steps/step_choose_review.dart';


class NewInhabitantStepsFactory {
  List<Step> getNewInhabitantSteps(BuildContext context, NewInhabitantScreenViewModel viewModel) {
    var list = [
      createNewInhabitantStep,
      createChooseAvatarStep,
      createReviewStep,
    ];
    viewModel.totalSteps = list.length;
    return list.mapIndexed((value, index) => value.call(context, index, viewModel));
  }
}

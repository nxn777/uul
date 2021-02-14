import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../newinhabitant/stepper/step_new_inhabitant.dart';
import '../../../common/steps/step_choose_avatar.dart';
import '../../../common/steps/step_choose_review.dart';
import '../edit_inhabitant_viewmodel.dart';


class EditInhabitantStepsFactory {
  List<Step> getEditInhabitantSteps(BuildContext context, EditInhabitantScreenViewModel viewModel) {
    var list = [
      createNewInhabitantStep,
      createChooseAvatarStep,
      createReviewStep,
    ];
    viewModel.totalSteps = list.length;
    return list.mapIndexed((value, index) => value.call(context, index, viewModel));
  }
}

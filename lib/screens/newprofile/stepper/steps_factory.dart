import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/screens/newprofile/stepper/step_choose_door.dart';
import 'package:UUL_Gym/screens/newprofile/stepper/step_choose_floor.dart';
import 'package:flutter/material.dart';

import 'step_choose_tower.dart';
import 'step_new_account.dart';

class NewProfileStepsFactory {
  List<Step> getNewProfileSteps(BuildContext context, NewProfileViewModel viewModel) {
    var list = [
      createNewAccountStep(context, 0, viewModel),
      createChooseTowerStep(context, 1, viewModel),
      createChooseFloorStep(context, 2, viewModel),
      createChooseDoorStep(context, 3, viewModel),
    ];
    viewModel.totalSteps = list.length;
    return list;
  }
}

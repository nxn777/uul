import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/stepper/step_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'stepper/steps_factory.dart';

class AddNewProfileScreen extends StatelessWidget {
  final NewProfileStepsFactory _stepsFactory = NewProfileStepsFactory();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewProfileViewModel>(
      create: (context) => NewProfileViewModel(),
      child: Consumer<NewProfileViewModel>(builder: (context, profileState, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
                  child: Text(
                    "New profile",
                    style: kPageTitleTextStyle,
                  ),
                ),
                Expanded(
                  child: ListView(children: [
                    Stepper(
                        physics: ScrollPhysics(),
                        onStepContinue: profileState.nextStep,
                        onStepCancel: profileState.cancelStep,
                        onStepTapped: profileState.gotoStep,
                        controlsBuilder: stepControlsBuilder,
                        steps: _stepsFactory.getNewProfileSteps(context, profileState)
                    ),
                  ]),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

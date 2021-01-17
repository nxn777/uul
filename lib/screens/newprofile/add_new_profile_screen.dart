import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/stepper/step_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'stepper/steps_factory.dart';
import 'package:UUL_Gym/common/function_extenstions.dart';

class AddNewProfileScreen extends StatelessWidget {
  final NewProfileStepsFactory _stepsFactory = NewProfileStepsFactory();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewProfileViewModel>(
      create: (context) => NewProfileViewModel(
        onUserCreated: (user) {
          Provider.of<AppState>(context, listen: false).addUser(user);
          Navigator.pop(context);
        },
      ),
      child: Consumer<NewProfileViewModel>(builder: (context, viewModel, child) {
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
                        onStepContinue: viewModel.nextStep,
                        onStepCancel: viewModel.clearStep,
                        onStepTapped: viewModel.gotoStep,
                        controlsBuilder: (_, {VoidCallback onStepContinue, VoidCallback onStepCancel}) => StepControls(
                              onStepContinue: viewModel.nextButtonIsEnabled()
                                  ? onStepContinue.also(() {
                                      FocusScope.of(context).unfocus();
                                    })
                                  : null,
                              onStepCancel: onStepCancel.also(() {
                                FocusScope.of(context).unfocus();
                              }),
                              nextTitle: viewModel.getNextButtonTitle(),
                              clearTitle: viewModel.getClearButtonTitle(),
                            ),
                        currentStep: viewModel.currentStep,
                        steps: _stepsFactory.getNewProfileSteps(context, viewModel)),
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

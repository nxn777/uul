import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/common/function_extenstions.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_screen_builder.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/stepper/step_controls.dart';
import 'package:UUL_Gym/widgets/title/screen_title.dart';
import 'package:flutter/material.dart';

import 'stepper/steps_factory.dart';

class NewProfileScreen extends StatelessWidget with ViewStateScreen<NewProfileViewModel> {
  final NewProfileStepsFactory _stepsFactory = NewProfileStepsFactory();

  @override
  NewProfileViewModel Function(BuildContext p1) vmCreator() => NewProfileScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(NewProfileViewModel viewModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenTitle("New profile"),
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
    );
  }
}

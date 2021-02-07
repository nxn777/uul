import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'new_profile_viewmodel.dart';
import 'stepper/steps_factory.dart';
import 'new_profile_screen_builder.dart';
import 'package:widgets/widgets.dart';
import 'package:extensions/extensions.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_presentation/common/steps_viewmodel.dart';
import 'package:widgets/widgets.dart';
import 'package:extensions/extensions.dart';

const List<Widget> _empty = [];
Widget getStepsScreenContent(String title, BuildContext context, StepsViewModel viewModel, List<Step> steps, {List<Widget> additional = _empty}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ScreenTitle(title),
      Expanded(
        child: ListView(
          children: [
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
              steps: steps,
            ),
          ].cast<Widget>()  + additional,
        ),
      )
    ],
  );
}

import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/common/steps_screen_content.dart';
import 'package:i18n/i18n.dart';

import 'new_profile_screen_builder.dart';
import 'new_profile_viewmodel.dart';
import 'stepper/steps_factory.dart';

class NewProfileScreen extends StatelessWidget with ViewStateScreen<NewProfileViewModel> {
  final NewProfileStepsFactory _stepsFactory = NewProfileStepsFactory();

  @override
  NewProfileViewModel Function(BuildContext p1) vmCreator() => NewProfileScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(NewProfileViewModel viewModel, BuildContext context) =>
      getStepsScreenContent("New profile".i18n, context, viewModel, _stepsFactory.getNewProfileSteps(context, viewModel));
}

import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/common/steps_screen_content.dart';
import 'package:user_presentation/screens/newinhabitant/new_inhabitant_screen_builder.dart';
import 'package:user_presentation/screens/newinhabitant/new_inhabitant_viewmodel.dart';
import 'package:user_presentation/screens/newinhabitant/stepper/steps_factory.dart';
import 'package:i18n/i18n.dart';

class NewInhabitantScreen extends StatelessWidget with ViewStateScreen<NewInhabitantScreenViewModel> {
  final NewInhabitantStepsFactory _stepsFactory = NewInhabitantStepsFactory();

  @override
  NewInhabitantScreenViewModel Function(BuildContext p1) vmCreator() => NewInhabitantScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(NewInhabitantScreenViewModel viewModel, BuildContext context)  =>
      getStepsScreenContent("New inhabitant".i18n, context, viewModel, _stepsFactory.getNewInhabitantSteps(context, viewModel));
}

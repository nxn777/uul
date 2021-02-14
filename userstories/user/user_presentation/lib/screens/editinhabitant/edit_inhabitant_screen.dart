import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/common/steps_screen_content.dart';

import 'edit_inhabitant_screen_builder.dart';
import 'edit_inhabitant_viewmodel.dart';
import './stepper/steps_factory.dart';

class EditInhabitantScreen extends StatelessWidget with ViewStateScreen<EditInhabitantScreenViewModel> {
  final EditInhabitantStepsFactory _stepsFactory = EditInhabitantStepsFactory();

  @override
  EditInhabitantScreenViewModel Function(BuildContext p1) vmCreator() => EditInhabitantScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(EditInhabitantScreenViewModel viewModel, BuildContext context)  =>
      getStepsScreenContent("Edit inhabitant", context, viewModel, _stepsFactory.getEditInhabitantSteps(context, viewModel));
}

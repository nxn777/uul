import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/screens/newinhabitant/new_inhabitant_screen_builder.dart';
import 'package:user_presentation/screens/newinhabitant/new_inhabitant_viewmodel.dart';

class NewInhabitantScreen extends StatelessWidget with ViewStateScreen<NewInhabitantScreenViewModel> {
  @override
  NewInhabitantScreenViewModel Function(BuildContext p1) vmCreator() => NewInhabitantScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(NewInhabitantScreenViewModel viewModel, BuildContext context) {
    // TODO: implement buildIdleState
    throw UnimplementedError();
  }
}

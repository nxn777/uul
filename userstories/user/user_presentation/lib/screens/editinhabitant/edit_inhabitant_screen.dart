
import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_presentation/common/steps_screen_content.dart';
import 'package:widgets/button/u_u_l_button.dart';
import 'package:widgets/widgets.dart';

import 'edit_inhabitant_screen_builder.dart';
import 'edit_inhabitant_viewmodel.dart';
import './stepper/steps_factory.dart';

class EditInhabitantScreen extends StatelessWidget with ViewStateScreen<EditInhabitantScreenViewModel> {
  final EditInhabitantStepsFactory _stepsFactory = EditInhabitantStepsFactory();

  @override
  EditInhabitantScreenViewModel Function(BuildContext p1) vmCreator() => EditInhabitantScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(EditInhabitantScreenViewModel viewModel, BuildContext context) =>
      getStepsScreenContent("Edit inhabitant", context, viewModel, _stepsFactory.getEditInhabitantSteps(context, viewModel), additional: getAdditionalWidgets(viewModel, context));

  List<Widget> getAdditionalWidgets(EditInhabitantScreenViewModel viewModel, BuildContext context) {
    List<Widget> result = List();
    result.add(Row(
      children: [
        SizedBox(
          width: kSpacingLarge,
        ),
        FaIcon(
          FontAwesomeIcons.exclamationCircle,
          color: Colors.redAccent,
        ),
        SizedBox(
          width: kSpacingXMedium,
        ),
        Expanded(
          child: UULButton(
            title: "Delete this inhabitant",
            isSolid: false,
            onPressed: () {
              AlertDialogBuilder(context)
                  .setTitle("Inhabitant deletion")
                  .setMessage("Are you sure you want to delete this inhabitant?\nThis can not be undone.")
                  .addCancel()
                  .addAction("Delete", isDestructive: true, onPressed: viewModel.deleteInhabitant)
                  .buildAndShow();
            },
          ),
        ),
        SizedBox(
          width: kSpacingLarge,
        ),
      ],
    ));
    result.add(SizedBox(
      height: kSpacingXLarge,
    ));
    if (viewModel.shouldShowDeleteProfile) {
      result.add(Row(
        children: [
          SizedBox(
            width: kSpacingLarge,
          ),
          FaIcon(
            FontAwesomeIcons.exclamationCircle,
            color: Colors.redAccent,
          ),
          SizedBox(
            width: kSpacingXMedium,
          ),
          Expanded(
            child: UULButton(
              title: "Delete this profile",
              isSolid: false,
              onPressed: () {
                AlertDialogBuilder(context)
                    .setTitle("Profile deletion")
                    .setMessage("Are you sure you want to delete this profile?\nThis can not be undone.")
                    .addCancel()
                    .addAction("Delete", isDestructive: true, onPressed: viewModel.deleteProfile)
                    .buildAndShow();
              },
            ),
          ),
          SizedBox(
            width: kSpacingLarge,
          ),
        ],
      ));
      result.add(SizedBox(
        height: kSpacingXLarge,
      ));
    }
    return result;
  }
}

import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/screens/editprofile/edit_profile_screen_builder.dart';
import 'package:user_presentation/screens/editprofile/edit_profile_viewmodel.dart';
import 'package:widgets/widgets.dart';

class EditProfileScreen extends StatelessWidget with ViewStateScreen<EditProfileViewModel> {
  @override
  EditProfileViewModel Function(BuildContext p1) vmCreator() => EditProfileScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(EditProfileViewModel viewModel, BuildContext context) {
    return ListView(
      children: [
        ScreenTitle("Edit profile"),

      ],
    );
  }

}
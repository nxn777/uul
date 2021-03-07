import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_presentation/screens/editprofile/edit_profile_screen_builder.dart';
import 'package:user_presentation/screens/editprofile/edit_profile_viewmodel.dart';
import 'package:user_presentation/validators/account_form_validator.dart';
import 'package:widgets/widgets.dart';
import 'package:i18n/i18n.dart';

class EditProfileScreen extends StatelessWidget with ViewStateScreen<EditProfileViewModel> {
  @override
  EditProfileViewModel Function(BuildContext p1) vmCreator() => EditProfileScreenBuilder.buildAndRunVM;

  @override
  Widget buildIdleState(EditProfileViewModel viewModel, BuildContext context) {
    var newPwdController = TextEditingController(text: viewModel.viewState.value.newPwd);
    var newPwd2Controller = TextEditingController(text: viewModel.viewState.value.newPwd2);
    var oldPwdController = TextEditingController(text: viewModel.viewState.value.oldPwd);
    return ListView(
      children: [
        ScreenTitle("Edit profile".i18n),
        SectionTitle("Change password".i18n),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacingMedium),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: oldPwdController,
                  decoration: InputDecoration(labelText: "Current password".i18n),
                  obscureText: true,
                  validator: AccountFormValidator.getPwdValidator(),
                  onChanged: (value) => viewModel.viewState.value.oldPwd = value,
                ),
                TextFormField(
                  controller: newPwdController,
                  decoration: InputDecoration(labelText: "New password".i18n),
                  obscureText: true,
                  validator: AccountFormValidator.getPwdValidator(),
                  onChanged: (value) => viewModel.viewState.value.newPwd = value,
                ),
                TextFormField(
                  controller: newPwd2Controller,
                  decoration: InputDecoration(labelText: "Repeat new password".i18n),
                  obscureText: true,
                  validator: (value) => AccountFormValidator.fieldEqualityValidator(viewModel.viewState.value.newPwd, value),
                  onChanged: (value) => viewModel.viewState.value.newPwd2 = value,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: kSpacingLarge,
        ),
        Row(
          children: [
            SizedBox(
              width: kSpacingLarge,
            ),
            FaIcon(
              FontAwesomeIcons.shieldAlt,
              color: kAccentColor,
            ),
            SizedBox(
              width: kSpacingXMedium,
            ),
            Expanded(
              child: UULButton(
                title: "Submit".i18n,
                isSolid: false,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  viewModel.changePassword();
                },
              ),
            ),
            SizedBox(
              width: kSpacingLarge,
            ),
          ],
        ),
        SectionTitle("Other".i18n),
        Row(
          children: [
            SizedBox(
              width: kSpacingLarge,
            ),
            FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: kAccentColor,
            ),
            SizedBox(
              width: kSpacingXMedium,
            ),
            Expanded(
              child: UULButton(
                title: "Logout".i18n,
                isSolid: false,
                onPressed: () {
                  AlertDialogBuilder(context)
                      .setTitle("Logout".i18n)
                      .setMessage("Are you sure you want to logout?".i18n)
                      .addCancel()
                      .addAction("Logout".i18n, onPressed: viewModel.logout)
                      .buildAndShow();
                },
              ),
            ),
            SizedBox(
              width: kSpacingLarge,
            ),
          ],
        ),
        SizedBox(
          height: kSpacingMedium,
        ),
        Row(
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
                title: "Delete this profile".i18n,
                isSolid: false,
                onPressed: () {
                  String pwd = "";
                  AlertDialogBuilder(context)
                      .setTitle("Profile deletion".i18n)
                      .setMessage("Are you sure you want to delete this profile?\nThis can not be undone.".i18n)
                      .addCancel()
                      .setTextField("Enter your password".i18n, valueChanged: (value) => pwd = value)
                      .addAction("Delete".i18n, isDestructive: true, onPressed: () => viewModel.deleteProfile(pwd))
                      .buildAndShow();
                },
              ),
            ),
            SizedBox(
              width: kSpacingLarge,
            ),
          ],
        ),
        SizedBox(
          height: kSpacingXLarge,
        )
      ],
    );
  }
}

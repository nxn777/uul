import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:user_presentation/validators/account_form_validator.dart';
import 'package:widgets/widgets.dart';

import 'login_screen_builder.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatelessWidget with ViewStateScreen<LoginViewModel> {
  @override
  LoginViewModel Function(BuildContext p1) vmCreator() => (context) => LoginScreenBuilder.buildAndRunVM(context);

  @override
  Widget buildIdleState(LoginViewModel viewModel, BuildContext context) {
    var so = viewModel.viewState.value;
    var nameController = TextEditingController(text: so.name);
    var pwdController = TextEditingController(text: so.pwd);
    return ListView(
      children: [
        ScreenTitle("Log in"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/common/uul_logo_transparent_wo_title.png",
              height: kSpacingHuge,
            ),
          ],
        ),
        Form(
          key: viewModel.accountFormKey,
          child: Padding(
            padding: const EdgeInsets.all(kSpacingMedium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  textCapitalization: TextCapitalization.words,
                  validator: AccountFormValidator.getNameValidator(),
                  onChanged: (value) => so.name = value,
                ),
                TextFormField(
                  controller: pwdController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: AccountFormValidator.getPwdValidator(),
                  onChanged: (value) => so.pwd = value,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: kSpacingMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            UULButton(
              title: "Log in",
              width: kSpacingHuge * 2,
              onPressed: () {
                viewModel.login(context);
              },
            ),
            SizedBox(
              width: kSpacingMedium,
            ),
            UULButton(
              title: "Cancel",
              width: kSpacingHuge * 2,
              isSolid: false,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
    var apartmentController = TextEditingController(text: so.apartmentCode);
    var loginController = TextEditingController(text: so.login);
    var pwdController = TextEditingController(text: so.pwd);
    var apartmentMaskFormatter = MaskTextInputFormatter(mask: 'A####', filter: { "#": RegExp(r'[0-9]'), "A": RegExp(r'[A-D]') });
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
                  controller: apartmentController,
                  decoration: InputDecoration(labelText: 'Apartment'),
                  textCapitalization: TextCapitalization.characters,
                  validator: AccountFormValidator.getApartmentValidator(),
                  onChanged: (value) => so.apartmentCode = value,
                  inputFormatters: [apartmentMaskFormatter],
                ),
                TextFormField(
                  controller: loginController,
                  decoration: InputDecoration(labelText: 'Name'),
                  textCapitalization: TextCapitalization.words,
                  validator: AccountFormValidator.getLoginValidator(),
                  onChanged: (value) => so.login = value,
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

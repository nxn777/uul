import 'package:flutter/material.dart';
import 'package:user_presentation/validators/account_form_validator.dart';
import '../new_profile_viewmodel.dart';
import 'package:i18n/i18n.dart';

Step createNewAccountStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  var nameController = TextEditingController(text: viewModel.name);
  var pwdController = TextEditingController(text: viewModel.pwd);
  var loginController = TextEditingController(text: viewModel.login);

  bool _newAccountStepValidator(viewModel) => (viewModel as NewProfileViewModel).formKey.currentState.validate();

  void _newAccountStepEraser(viewModel)  {
      var typedVm = viewModel as NewProfileViewModel;
      nameController.clear();
      pwdController.clear();
      typedVm.name = "";
      typedVm.pwd = "";
      typedVm.login = "";
  }

  bool _stepEnabler(viewModel) => true;

  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _newAccountStepValidator);
  viewModel.registerEraser(index, _newAccountStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Account".i18n),
    content: Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: loginController,
            decoration: InputDecoration(labelText: 'Login'.i18n),
            textCapitalization: TextCapitalization.words,
            validator: AccountFormValidator.getLoginValidator(),
            onChanged: (value) => viewModel.login = value,
          ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name (will be visible for everyone)'.i18n),
            textCapitalization: TextCapitalization.words,
            validator: AccountFormValidator.getNameValidator(),
            onChanged: (value) => viewModel.name = value,
          ),
          TextFormField(
            controller: pwdController,
            decoration: InputDecoration(labelText: 'Password'.i18n),
            obscureText: true,
            validator: AccountFormValidator.getPwdValidator(),
            onChanged: (value) => viewModel.pwd = value,
          ),
        ],
      ),
    ),
  );
}

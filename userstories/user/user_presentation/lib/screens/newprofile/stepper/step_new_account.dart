import 'package:flutter/material.dart';
import 'package:user_presentation/validators/account_form_validator.dart';

import '../new_profile_viewmodel.dart';

Step createNewAccountStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  var nameController = TextEditingController(text: viewModel.name);
  var pwdController = TextEditingController(text: viewModel.pwd);

  bool _newAccountStepValidator(NewProfileViewModel viewModel) {
    return viewModel.accountFormKey.currentState.validate();
  }

  void _newAccountStepEraser(NewProfileViewModel viewModel) {
    nameController.clear();
    pwdController.clear();
    viewModel.name = "";
    viewModel.pwd = "";
  }

  bool _stepEnabler(NewProfileViewModel viewModel) => true;
  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _newAccountStepValidator);
  viewModel.registerEraser(index, _newAccountStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Account"),
    content: Form(
      key: viewModel.accountFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name (will be visible for everyone)'),
            textCapitalization: TextCapitalization.words,
            validator: AccountFormValidator.getNameValidator(),
            onChanged: (value) => viewModel.name = value,
          ),
          TextFormField(
            controller: pwdController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: AccountFormValidator.getPwdValidator(),
            onChanged: (value) => viewModel.pwd = value,
          ),
        ],
      ),
    ),
  );
}

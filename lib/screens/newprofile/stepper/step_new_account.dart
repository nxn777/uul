
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:flutter/material.dart';

Step createNewAccountStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  var nameController = TextEditingController(text: viewModel.name);
  var pwdController = TextEditingController(text: viewModel.pwd);

  String _nameValidationErrorMessage(String name) {
    return  name.isNotEmpty ? null : "Name should not be empty";
  }

  String _pwdValidationErrorMessage(String pwd) {
    return  pwd.length > 4 ? null : "Should be at least 5 characters long";
  }

  bool _newAccountStepValidator(NewProfileViewModel viewModel) {
    return viewModel.accountFormKey.currentState.validate();
  }

  void _newAccountStepEraser(NewProfileViewModel viewModel) {
    nameController.clear();
    pwdController.clear();
    viewModel.name = "";
    viewModel.pwd = "";
  }

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
            validator: _nameValidationErrorMessage,
            onChanged: (value) => viewModel.name = value,
          ),
          TextFormField(
            controller: pwdController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: _pwdValidationErrorMessage,
            onChanged: (value) => viewModel.pwd = value,
          ),
        ],
      ),
    ),
  );


}


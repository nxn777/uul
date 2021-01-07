
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:flutter/material.dart';

Step createNewAccountStep(BuildContext context, int index, NewProfileViewModel viewModel) {
  viewModel.registerValidator(index, _newAccountStepValidator);
  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Account"),
    content: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Name (will be visible for everyone)'),
          textCapitalization: TextCapitalization.words,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) => value.length < 5 ? "Should be at least 5 characters" : null,
        ),
      ],
    ),
  );
}

bool _newAccountStepValidator(NewProfileViewModel viewModel) {
  return false;
}
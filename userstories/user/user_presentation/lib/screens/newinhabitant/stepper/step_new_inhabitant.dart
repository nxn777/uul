import 'package:flutter/material.dart';
import 'package:user_presentation/screens/newinhabitant/new_inhabitant_viewmodel.dart';
import 'package:user_presentation/validators/account_form_validator.dart';


Step createNewInhabitantStep(BuildContext context, int index, NewInhabitantScreenViewModel viewModel) {
  var nameController = TextEditingController(text: viewModel.name);

  bool _newAccountStepValidator(viewModel) => (viewModel as NewInhabitantScreenViewModel).formKey.currentState.validate();

  void _newAccountStepEraser(viewModel)  {
    var typedVm = viewModel as NewInhabitantScreenViewModel;
    nameController.clear();
    typedVm.name = "";
  }

  bool _stepEnabler(viewModel) => true;

  viewModel.registerEnabler(index, _stepEnabler);
  viewModel.registerValidator(index, _newAccountStepValidator);
  viewModel.registerEraser(index, _newAccountStepEraser);

  return Step(
    isActive: viewModel.isStepActive(index),
    state: viewModel.getStepState(index),
    title: Text("Inhabitant"),
    content: Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name (will be visible for everyone)'),
            textCapitalization: TextCapitalization.words,
            validator: AccountFormValidator.getNameValidator(),
            onChanged: (value) => viewModel.name = value,
          ),
        ],
      ),
    ),
  );
}

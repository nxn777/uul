import 'package:flutter/material.dart';
import 'package:user_presentation/validators/account_form_validator.dart';
import '../../../common/inhabitant_viewmodel.dart';

Step createNewInhabitantStep(BuildContext context, int index, InhabitantViewModel viewModel) {
  var nameController = TextEditingController(text: viewModel.name);

  bool _newAccountStepValidator(viewModel) => (viewModel as InhabitantViewModel).formKey.currentState.validate();

  void _newAccountStepEraser(viewModel)  {
    var typedVm = viewModel as InhabitantViewModel;
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

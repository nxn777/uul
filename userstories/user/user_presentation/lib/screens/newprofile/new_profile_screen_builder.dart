import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'new_profile_viewmodel.dart';
import 'package:di/di.dart';

class NewProfileScreenBuilder {
  NewProfileScreenBuilder._();

  static NewProfileViewModel buildAndRunVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = globalDependencies.dependenciesProvider.userModule.createUserRepo();
    var rulesRepo = globalDependencies.dependenciesProvider.rulesModule.createRulesRepo();
    var vm = NewProfileViewModel(userRepo,rulesRepo, onUserCreated: (user) => Navigator.of(context).pop(true));
    vm.fetchData();
    return vm;
  }
}

import 'package:di/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'user_profiles_viewmodel.dart';

class UserProfilesScreenBuilder {
  UserProfilesScreenBuilder._();

  static UserProfilesViewModel buildAndStartVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = globalDependencies.dependenciesProvider.userModule.createUserRepo();
    var rulesRepo = globalDependencies.dependenciesProvider.rulesModule.createRulesRepo();
    var vm = UserProfilesViewModel(userRepo, rulesRepo);
    vm.fetchData();
    return vm;
  }
}

import 'file:///C:/local/flutter/UUL_Gym/userstories/rules/rules_data/lib/src/rules_repo.dart';
import 'package:UUL_Gym/data/repo/user_repo.dart';
import 'file:///C:/local/flutter/UUL_Gym/di/lib/src/global_dependencies.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserProfilesScreenBuilder {
  UserProfilesScreenBuilder._();

  static UserProfilesViewModel buildAndStartVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = UserRepo(globalDependencies.kvStore);
    var rulesRepo = RulesRepo(globalDependencies.kvStore);
    var vm = UserProfilesViewModel(userRepo, rulesRepo);
    vm.fetchData();
    return vm;
  }
}

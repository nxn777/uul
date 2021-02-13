import 'package:di/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'new_inhabitant_viewmodel.dart';

class NewInhabitantScreenBuilder {
  NewInhabitantScreenBuilder._();

  static NewInhabitantScreenViewModel buildAndRunVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = globalDependencies.dependenciesProvider.userModule.createUserRepo();
    var vm = NewInhabitantScreenViewModel(userRepo);
    vm.fetchData();
    return vm;
  }
}

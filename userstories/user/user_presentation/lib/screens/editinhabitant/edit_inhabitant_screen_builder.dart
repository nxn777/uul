import 'package:di/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'edit_inhabitant_viewmodel.dart';


class EditInhabitantScreenBuilder {
  EditInhabitantScreenBuilder._();

  static EditInhabitantScreenViewModel buildAndRunVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = globalDependencies.dependenciesProvider.userModule.createUserRepo();
    var vm = EditInhabitantScreenViewModel(context, userRepo);
    vm.fetchData();
    return vm;
  }
}

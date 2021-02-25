import 'package:di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'time_slots_viewmodel.dart';

class TimeSlotsScreenBuilder {
  TimeSlotsScreenBuilder._();

  static TimeSlotsViewModel buildAndStartVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var gymRepo = globalDependencies.dependenciesProvider.timeSlotsModule.createGymRepo();
    var rulesRepo = globalDependencies.dependenciesProvider.rulesModule.getRulesRepoSingleton();
    var timeSlotsRepo = globalDependencies.dependenciesProvider.timeSlotsModule.createScheduleRepo();
    var userRepo = globalDependencies.dependenciesProvider.userModule.createUserRepo();
    var deepLinkExecutor = globalDependencies.deepLinkCommandExecutor;
    var vm = TimeSlotsViewModel(userRepo, gymRepo, rulesRepo, timeSlotsRepo, deepLinkExecutor);
    vm.fetchData();
    return vm;
  }
}

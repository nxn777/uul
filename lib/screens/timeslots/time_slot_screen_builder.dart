import 'package:UUL_Gym/data/repo/gym_repo.dart';
import 'package:UUL_Gym/data/repo/rules_repo.dart';
import 'package:UUL_Gym/data/repo/timeslots_repo.dart';
import 'package:UUL_Gym/di/global_dependencies.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'time_slots_viewmodel.dart';

class TimeSlotsScreenBuilder {
  TimeSlotsScreenBuilder._();

  static TimeSlotsViewModel buildAndStartVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var gymRepo = GymRepo(globalDependencies.kvStore);
    var rulesRepo = RulesRepo();
    var timeSlotsRepo = TimeSlotsRepo();
    var vm = TimeSlotsViewModel(gymRepo, rulesRepo, timeSlotsRepo);
    vm.fetchData();
    return vm;
  }
}
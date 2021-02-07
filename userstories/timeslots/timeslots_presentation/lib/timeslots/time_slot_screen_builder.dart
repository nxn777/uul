import 'package:timeslots_api/timeslots_api.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'time_slots_viewmodel.dart';

class TimeSlotsScreenBuilder {
  TimeSlotsScreenBuilder._();

  static TimeSlotsViewModel buildAndStartVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var gymRepo = GymRepo(globalDependencies.kvStore);
    var rulesRepo = RulesRepo(globalDependencies.kvStore);
    var timeSlotsRepo = TimeSlotsRepo();
    var vm = TimeSlotsViewModel(gymRepo, rulesRepo, timeSlotsRepo);
    vm.fetchData();
    return vm;
  }
}

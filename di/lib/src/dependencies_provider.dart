import 'package:di/src/global_dependencies.dart';
import 'package:di/src/modules/rules_module.dart';
import 'package:di/src/modules/timeslots_module.dart';

class DependenciesProvider {
  final RulesModule rulesModule;
  final TimeSlotsModule timeSlotsModule;

  DependenciesProvider(GlobalDependencies globalDependencies)
      : rulesModule = RulesModule(globalDependencies.kvStore),
        timeSlotsModule = TimeSlotsModule(globalDependencies.kvStore);
}

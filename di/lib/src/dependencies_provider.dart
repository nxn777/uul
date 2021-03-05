import 'package:di/src/global_dependencies.dart';
import 'package:di/src/modules/news_module.dart';
import 'package:di/src/modules/rules_module.dart';
import 'package:di/src/modules/timeslots_module.dart';
import 'package:di/src/modules/user_module.dart';

class DependenciesProvider {
  final RulesModule rulesModule;
  final TimeSlotsModule timeSlotsModule;
  final UserModule userModule;
  final NewsModule newsModule;
  DependenciesProvider(GlobalDependencies globalDependencies)
      : rulesModule = RulesModule(globalDependencies.kvStore),
        timeSlotsModule = TimeSlotsModule(globalDependencies.kvStore, globalDependencies.uulDio),
        userModule = UserModule(globalDependencies.kvStore, globalDependencies.uulDio),
        newsModule = NewsModule(globalDependencies.kvStore, globalDependencies.uulDio);
}

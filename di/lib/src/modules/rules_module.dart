import 'package:persistence_api/persistence_api.dart';
import 'package:rules_api/rules_api.dart';
import 'package:rules_data/rules_data.dart';

class RulesModule {
  RulesRepo _rulesRepo;
  RulesModule(KVStore _kvStore): _rulesRepo = DefaultRulesRepo(_kvStore);

  RulesRepo getRulesRepoSingleton() => _rulesRepo;
}

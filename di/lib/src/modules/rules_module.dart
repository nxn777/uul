import 'package:persistence_api/persistence_api.dart';
import 'package:rules_api/rules_api.dart';
import 'package:rules_data/rules_data.dart';

class RulesModule {
  KVStore _kvStore;

  RulesModule(this._kvStore);

  RulesRepo createRulesRepo() => DefaultRulesRepo(_kvStore);
}

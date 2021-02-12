import 'package:core/core.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:rules_api/rules_api.dart';
import 'package:caching/caching.dart';
import 'rules_api_client.dart';
import 'rules_dtos.dart';

const String _CACHED_RULES = "cached_rules";

class DefaultRulesRepo implements RulesRepo {
  final KVStore _store;
  Future<UULResult<Rules>> _ongoing;

  DefaultRulesRepo(this._store);

  Future<UULResult<Rules>> loadRules({bool forced = false}) async {
    if (_ongoing != null) { return  _ongoing; }
    var cachingRequest = CachingRequest<Rules, RulesDTO>(_CACHED_RULES, _store, networkCall: () => RulesApiClient.fetchRules());
    _ongoing = cachingRequest.call(forced, RulesDTO());
    _ongoing.whenComplete(() => _ongoing = null);
    return _ongoing;
  }
}

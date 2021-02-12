import 'package:core/core.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:rules_api/rules_api.dart';
import 'package:caching/caching.dart';
import 'rules_api_client.dart';
import 'rules_dtos.dart';

const String _CACHED_RULES = "cached_rules";

class DefaultRulesRepo implements RulesRepo {
  final KVStore _store;

  DefaultRulesRepo(this._store);

  Future<UULResult<Rules>> loadRules({bool forced = false}) async {
    var cachingRequest = CachingRequest<Rules, RulesDTO>(_CACHED_RULES, _store, networkCall: () => RulesApiClient.fetchRules());
    return cachingRequest.call(forced, RulesDTO());
    // if (!forced) {
    //   var _cachedRawData = _store.getString(_CACHED_RULES, "");
    //   if (_cachedRawData.isNotEmpty) {
    //     var dto = new RulesDTO();
    //     return UULResult.success(UULResponse.fromCachedData(_cachedRawData, dto).data.mapToDomain());
    //   }
    // }
    // var response = await RulesApiClient.fetchRules();
    // await _store.setString(_CACHED_RULES, response.rawData);
    // if (response.isSuccess) {
    //   return UULResult.success(response.data.mapToDomain());
    // } else {
    //   return UULResult.failure(response);
    // }
  }
}

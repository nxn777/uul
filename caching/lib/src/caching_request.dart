import 'package:flutter/foundation.dart';
import 'package:rest/rest.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:core/core.dart';

class CachingRequest<D, T extends HasMapToDomain<D>> {
  final KVStore _store;
  final Future<UULResponse<T>> Function() _networkCall;
  final String storeKey;

  CachingRequest(this.storeKey, this._store, {@required Future<UULResponse<T>> Function() networkCall}) : _networkCall = networkCall;

  Future<UULResult<D>> call(bool forced, T dto, {bool skipCaching = false}) async {
    if (!forced) {
      debugPrint("CachingRequest for $storeKey is not forced, looking for cache...");
      var _cachedRawData = _store.getString(storeKey, "");
      if (_cachedRawData.isNotEmpty) {
        debugPrint("CachingRequest for $storeKey found cached data!");
        return UULResult.success(UULResponse.fromCachedData(_cachedRawData, dto).data.mapToDomain());
      }
    }
    debugPrint("CachingRequest for $storeKey firing, will cache: ${!skipCaching}");
    var response = await _networkCall();
    if (response.isSuccess) {
      if (!skipCaching) {
        await _store.setString(storeKey, response.rawData);
        debugPrint("CachingRequest for $storeKey stored");
      }
      return UULResult.success(response.data.mapToDomain());
    } else {
      return UULResult.failure(response);
    }
  }
}
import 'package:flutter/foundation.dart';
import 'package:rest/rest.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:core/core.dart';

abstract class HasMapToDomain<D> implements HasFromJson {
  D mapToDomain();
}

class CachingRequest<D, T extends HasMapToDomain<D>> {
  final KVStore _store;
  final Future<UULResponse<T>> Function() _networkCall;
  final String storeKey;

  CachingRequest(this.storeKey, this._store, {@required Future<UULResponse<T>> Function() networkCall}) : _networkCall = networkCall;

  Future<UULResult<D>> call(bool forced, T dto) async {
    if (!forced) {
      var _cachedRawData = _store.getString(storeKey, "");
      if (_cachedRawData.isNotEmpty) {
        return UULResult.success(UULResponse.fromCachedData(_cachedRawData, dto).data.mapToDomain());
      }
    }
    var response = await _networkCall();
    await _store.setString(storeKey, response.rawData);
    if (response.isSuccess) {
      return UULResult.success(response.data.mapToDomain());
    } else {
      return UULResult.failure(response);
    }
  }
}
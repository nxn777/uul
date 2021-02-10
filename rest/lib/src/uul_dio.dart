
import 'package:dio/dio.dart';
import 'package:persistence_api/persistence_api.dart';

import 'dio_factory.dart';

const String _TOKEN_KEY = "token_key";
class UULDio {
  final KVStore _kvStore;
  Dio _instance;

  UULDio(this._kvStore);

  Dio getInstance() {
    if (_instance == null) {
      _instance = createDio();
      _instance.interceptors.add(InterceptorsWrapper(onRequest: (Options options) {
        var token = _kvStore.getString(_TOKEN_KEY, "");
        options.headers["Authorization"] = "Bearer $token";
      }));
    }
    return _instance;
  }
  
  Future<bool> updateToken(String token) => _kvStore.setString(_TOKEN_KEY, token);
  
}
import 'package:core/core.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:user_api/user_api.dart';
import 'package:user_data/user_data.dart';
import 'apiclient/user_api_client.dart';
import 'package:caching/caching.dart';
import 'user_dtos.dart';
const String _ACTIVE_USER_ID = "active_usr_id";
const String _CACHED_USER = "cached_user";

class DefaultUserRepo  implements UserRepo {
  final KVStore _store;
  final UserApiClient apiClient;

  DefaultUserRepo(this._store, this.apiClient);

  @override
  Future<bool> login({String apartment, String login, String pwd}) async {
    var response = await apiClient.login(apartment, login, pwd);
    if (response.isSuccess) {

      return true;
    } else {
      return false;
    }
  }

  @override
  Future logout() => apiClient.logout();

  @override
  Future<UULResult<User>> addNewProfile({String login, String name, String password, String apartment, String avatarSrc}) {
    // TODO: implement addNewProfile

    throw UnimplementedError();
  }

  @override
  Future<UULResult<User>> getUser({bool forced = false}) async {
    var cachingRequest = CachingRequest<User, UserDTO>(_CACHED_USER, _store, networkCall: () => apiClient.fetchUser());
    return cachingRequest.call(forced, UserDTO());
    // if (!forced) {
    //   var _cachedRawData = _store.getString(_CACHED_USER, "");
    //   if (_cachedRawData.isNotEmpty) {
    //     var dto = new UserDTO();
    //     return UULResult.success(UULResponse.fromCachedData(_cachedRawData, dto).data.mapToDomain());
    //   }
    // }
    // var response = await apiClient.fetchUser();
    // await _store.setString(_CACHED_USER, response.rawData);
    // if (response.isSuccess) {
    //   return UULResult.success(response.data.mapToDomain());
    // } else {
    //   return UULResult.failure(response);
    // }
  }

}

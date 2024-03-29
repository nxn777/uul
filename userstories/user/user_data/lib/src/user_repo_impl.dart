import 'package:caching/caching.dart';
import 'package:core/core.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:user_api/user_api.dart';
import 'package:user_data/user_data.dart';
import 'apiclient/user_api_client.dart';

import 'user_dtos.dart';

const String _ACTIVE_INHABITANT_ID = "active_inh_id";
const String _CACHED_USER = "cached_user";
const String _CURRENT_INHABITANT_ID = "current_inh_id";

class DefaultUserRepo  implements UserRepo {
  final KVStore _store;
  final UserApiClient apiClient;

  DefaultUserRepo(this._store, this.apiClient);

  @override
  Future<bool> login({String apartment, String login, String pwd}) async {
    var response = await apiClient.login(apartment, login, pwd);
    return response.isSuccess;
  }

  @override
  Future logout() {
    var network = apiClient.logout();
    var store = _store.clearAll();
    return Future.wait([network, store]);
  }

  @override
  bool isLoggedIn() => apiClient.hasToken();

  @override
  Future<UULResult<User>> addNewProfile({String login, String name, String password, String apartment, String avatarSrc}) {
    NewUserDTO dto = NewUserDTO(login: login, name: name, pwd: password, apartmentCode: apartment, avatarSrc: avatarSrc);
    var cachingRequest = CachingRequest<User, UserDTO>(_CACHED_USER, _store, networkCall: () => apiClient.addUser(dto));
    return cachingRequest.call(true, UserDTO());
  }

  @override
  Future<UULResult<User>> changeProfilePassword({String newPassword, String oldPassword, String apartment, String login,}) {
    var cachingRequest = CachingRequest<User, UserDTO>(_CACHED_USER, _store, networkCall: () => apiClient.changePassword(newPassword, oldPassword, apartment, login));
    return cachingRequest.call(true, UserDTO());
  }

  @override
  Future<UULResult<bool>> deleteProfile({String login, String password, String apartment}) async {
    NewUserDTO dto = NewUserDTO(login: login, pwd: password, apartmentCode: apartment);
    var response = await apiClient.deleteUser(dto);
    if (response.isSuccess) {
      await logout();
      return UULResult.success(true);
    } else {
      return UULResult.failure(response);
    }
  }

  @override
  Future<UULResult<User>> addNewInhabitant({String name, String avatarSrc}) {
    var cachingRequest = CachingRequest<User, UserDTO>(_CACHED_USER, _store, networkCall: () => apiClient.addInhabitant(name, avatarSrc));
    return cachingRequest.call(true, UserDTO());
  }

  @override
  Future<UULResult<User>> editInhabitant({int id, String name, String avatarSrc}) {
    var cachingRequest = CachingRequest<User, UserDTO>(_CACHED_USER, _store, networkCall: () => apiClient.editInhabitant(id, name, avatarSrc));
    return cachingRequest.call(true, UserDTO());
  }

  @override
  Future<UULResult<User>> deleteInhabitant(int id) {
    var cachingRequest = CachingRequest<User, UserDTO>(_CACHED_USER, _store, networkCall: () => apiClient.deleteInhabitant(id));
    return cachingRequest.call(true, UserDTO());
  }

  @override
  Future<UULResult<User>> getUser({bool forced = false}) async {
    var cachingRequest = CachingRequest<User, UserDTO>(_CACHED_USER, _store, networkCall: () => apiClient.fetchUser());
    return cachingRequest.call(forced, UserDTO());
  }

  @override
  int getActiveInhabitantId() => _store.getInteger(_ACTIVE_INHABITANT_ID, -1);

  @override
  Future<bool> setActiveInhabitantId(int id) => this._store.setInt(_ACTIVE_INHABITANT_ID, id);

  @override
  Future<bool> setCurrentInhabitantId(int id) => this._store.setInt(_CURRENT_INHABITANT_ID, id);

  @override
  int getCurrentInhabitantId() => this._store.getInteger(_CURRENT_INHABITANT_ID, -1);

}

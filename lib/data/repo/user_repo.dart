import 'dart:convert';

import 'package:UUL_Gym/common/kv_store.dart';
import 'package:UUL_Gym/data/apiclient/user_api_client.dart';
import 'package:UUL_Gym/models/user.dart';

const String _ACTIVE_USER_ID = "active_usr_id";
const String _CACHED_USERS = "cached_users";

class UserRepo {
  final KVStore _store;

  UserRepo(this._store);

  int getActiveUserId() => _store.getInteger(_ACTIVE_USER_ID, -1);

  Future<bool> setActiveUserId(int id) => _store.setInt(_ACTIVE_USER_ID, id);

  Future<bool> rewriteCachedUsers(List<User> users) {
    List<String> raw = users.map((e) => jsonEncode(e.toJson())).toList();
    return _store.setStringList(_CACHED_USERS, raw);
  }

  Future<List<User>> fetchAndCacheUsers(String user, String pwd) async {
    var fetched = await UserApiClient.getApartmentUsers(user, pwd);
    await rewriteCachedUsers(fetched);
    return fetched;
  }

  User getActiveOrFirstCachedUser() {
    var cached = _getCachedUsers();
    var activeId = getActiveUserId();
    var active = cached.firstWhere((element) => element.id == activeId, orElse: () => null);
    if (active != null) {
      return active;
    }
    if (cached.isNotEmpty) {
      return cached.first;
    }
    return null;
  }

  Future<List<bool>> deleteAll() {
    return Future.wait([setActiveUserId(-1), rewriteCachedUsers(List.empty())]);
  }

  Future<List<User>> addUser(User user) async {
    var existent = _getCachedUsers();
    var fetched = await UserApiClient.addApartmentUser(user, existent);
    await rewriteCachedUsers(fetched);
    await setActiveUserId(fetched.first.id);
    return fetched;
  }

  List<User> _getCachedUsers() {
    List<String> raw = _store.getStringList(_CACHED_USERS);
    if (raw.isEmpty) {
      return List.empty();
    }
    return raw.map((e) => User.fromJson(e)).toList();
  }
}

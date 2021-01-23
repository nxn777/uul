import 'package:UUL_Gym/common/kv_store.dart';
import 'package:UUL_Gym/data/apiclient/user_api_client.dart';
import 'dart:convert';
import 'package:UUL_Gym/models/user.dart';

const String _ACTIVE_USER_ID = "active_usr_id";
const String _CACHED_USERS = "cached_users";
class UserRepo {
  final KVStore _store;

  UserRepo(this._store);

  int getActiveUserId() => _store.getInteger(_ACTIVE_USER_ID, -1);
  Future<bool> setActiveUserId(int id) => _store.setInt(_ACTIVE_USER_ID, id);

  List<User> getCachedUsers() {
    List<String> raw = _store.getStringList(_CACHED_USERS);
    if (raw.isEmpty) {
      return List.empty();
    }
    return raw.map((e) => User.fromJson(e));
  }

  Future<bool> rewriteCachedUsers(List<User> users) {
    List<String> raw = users.map((e) => jsonEncode(e.toJson()));
    return _store.setStringList(_CACHED_USERS, raw);
  }

  Future<List<User>> fetchAndCacheUsers(String user, String pwd) async {
    var fetched = await UserApiClient.getAppartmentUsers(user, pwd);
    await rewriteCachedUsers(fetched);
    return fetched;
  }
}
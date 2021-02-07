import 'package:core/core.dart';

abstract class UserRepo {
  int getActiveUserId();

  Future<bool> setActiveUserId(int id);

  Future<bool> rewriteCachedUsers(List<User> users);

  Future<List<User>> fetchAndCacheUsers(String user, String pwd);

  User getActiveOrFirstCachedUser();

  Future<List<bool>> deleteAll();

  Future<List<User>> addUser(User user);
}
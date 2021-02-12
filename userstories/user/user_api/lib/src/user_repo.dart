import 'package:core/core.dart';

abstract class UserRepo {
  Future<bool> login({String apartment, String login, String pwd});
  Future logout();
  Future<UULResult<User>> getUser({bool forced = false});
  Future<UULResult<User>> addNewProfile({String login, String name, String password, String apartment, String avatarSrc});
  int getActiveInhabitantId();
}

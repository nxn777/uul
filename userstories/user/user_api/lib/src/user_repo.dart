import 'package:core/core.dart';

abstract class UserRepo {
  Future<bool> login({String apartment, String login, String pwd});
  Future logout();
  Future<UULResult<User>> getUser({bool forced = false});
  Future<UULResult<User>> addNewProfile({String login, String name, String password, String apartment, String avatarSrc});
  Future<UULResult<bool>> deleteProfile({String login, String password, String apartment});
  Future<UULResult<User>> addNewInhabitant({String name, String avatarSrc});
  Future<UULResult<User>> editInhabitant({int id, String name, String avatarSrc});
  Future<UULResult<User>> deleteInhabitant(int id);
  int getActiveInhabitantId();
  Future<bool> setCurrentInhabitantId(int id);
  int getCurrentInhabitantId();
}

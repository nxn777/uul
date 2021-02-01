import 'dart:math';

import 'package:UUL_Gym/common/list_extensions.dart';
import 'package:UUL_Gym/models/user.dart';

class UserApiClient {
  UserApiClient._();

  static Future<List<User>> getApartmentUsers(String user, String pwd) {
    return Future.delayed(Duration(seconds: 1), () => _generateTestData(user, pwd));
  }

  static Future<List<User>> addApartmentUser(User user, List<User> mockedExistent) {
    return Future.delayed(Duration(seconds: 1), () {
      var updated = mockedExistent.toList();
          updated.add(user);
      return updated;
    });
  }

  static List<User> _generateTestData(String user, pwd) => List(5).mapIndexed((value, index) => User(
      id: index,
      name: user + index.toString(),
      pwdHash: pwd,
      avatarImageSrc: "assets/avatars/user (${Random().nextInt(35) + 1}).png",
      isActivated: index % 2 == 0,
      apartmentCode: "C1207"));
}

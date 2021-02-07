import 'dart:math';

import 'package:core/core.dart';
import 'package:extensions/extensions.dart';
import 'package:rest/rest.dart';

const String _kUsersApiPath = "/api/users/";

class UserApiClient {
  UserApiClient._();

  static Future<List<User>> getApartmentUsers(String user, String pwd) {
    return Future.delayed(Duration(seconds: 1), () => _generateTestData(user, pwd));
  }

  static Future<List<User>> addApartmentUser(User user, List<User> mockedExistent) async {
    final response = await getDio().post(_kUsersApiPath + "new", data: user.toJson()); //http.post(_ad_dUserUrl, headers: kBaseHeaders, body: jsonEncode(user.toJson()));

    return Future.value(mockedExistent);
  }

  static List<User> _generateTestData(String user, pwd) => List(5).mapIndexed((value, index) => User(
      id: index,
      name: user + index.toString(),
      pwdHash: pwd,
      avatarImageSrc: "assets/avatars/user (${Random().nextInt(35) + 1}).png",
      isActivated: index % 2 == 0,
      apartmentCode: "C1207"));
}

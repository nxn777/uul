import 'dart:convert';

import 'package:UUL_Gym/models/appartment.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:crypto/crypto.dart';
import 'package:UUL_Gym/common/list_extensions.dart';

class UserApiClient {
  UserApiClient._();

  static Future<List<User>> getAppartmentUsers(String user, String pwd) {
    var pwdHash = sha256.convert(utf8.encode(pwd)).toString();
    print(pwdHash);
    return Future.delayed(Duration(seconds: 1), () => _generateTestData(user, pwd));
  }

  static List<User> _generateTestData(String user, pwd) => List(3)
        .mapIndexed((value, index) => User(id: index, name: user + index.toString(), pwdHash: pwd, avatarImageSrc: "assets/avatars/user (1).png", isActivated: false, appartment: Appartment(id: 0, code: "C1207")));

}

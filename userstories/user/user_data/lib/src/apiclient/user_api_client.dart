import 'dart:math';

import 'package:core/core.dart';
import 'package:extensions/extensions.dart';
import 'package:rest/rest.dart';

abstract class UserApiClient {
  Future<UULResponse<TokenDTO>> login(String apartment, login, pwd);
  Future logout();
}

class DefaultUserApiClient implements UserApiClient {
  final UULDio uulDio;
  DefaultUserApiClient(this.uulDio);

  @override
  Future<UULResponse<TokenDTO>> login(String apartment, login, pwd) async {
    var response;
    try {
      response = await getDio().post("/api/users/login", data: {"login": login, "pwd": pwd, "apartmentCode": apartment});
      var result = UULResponse.fromResponse(response, TokenDTO());
      if (result.isSuccess) {
        uulDio.updateToken(result.data.value);
      }
      return result;
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  @override
  Future logout() {
    uulDio.updateToken(null);
    return Future.value("");
  }

  static Future<List<User>> getApartmentUsers(String user, String pwd) {
    return Future.delayed(Duration(seconds: 1), () => _generateTestData(user, pwd));
  }

  static Future<List<User>> addApartmentUser(User user, List<User> mockedExistent) async {
    //final response = await getDio().post(_kUsersApiPath + "new", data: user.toJson()); //http.post(_ad_dUserUrl, headers: kBaseHeaders, body: jsonEncode(user.toJson()));

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

class TokenDTO implements HasFromJson {
  String value;

  @override
  populateFromJson(jsonRaw) {
    value = jsonRaw.toString();
  }
}

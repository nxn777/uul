import 'package:rest/rest.dart';
import '../user_dtos.dart';

abstract class UserApiClient {
  Future<UULResponse<TokenDTO>> login(String apartment, login, pwd);
  Future logout();
  Future<UULResponse<UserDTO>> fetchUser();
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

  @override
  Future<UULResponse<UserDTO>> fetchUser() async {
    var response;
    try {
      response = await uulDio.getInstance().get("/api/users/info");
      return UULResponse.fromResponse(response, UserDTO());
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }
}
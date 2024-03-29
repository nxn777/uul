import 'package:rest/rest.dart';
import '../user_dtos.dart';

abstract class UserApiClient {
  Future<UULResponse<TokenDTO>> login(String apartment, login, pwd);
  Future logout();
  Future<UULResponse<UserDTO>> fetchUser();
  Future<UULResponse<UserDTO>> addUser(NewUserDTO dto);
  Future<UULResponse<UserDTO>> changePassword(String newPwd, String oldPwd, String apartment, String login);
  Future<UULResponse<SingleValueDTO>> deleteUser(NewUserDTO dto);
  Future<UULResponse<UserDTO>> addInhabitant(String name, String avatarSrc);
  Future<UULResponse<UserDTO>> editInhabitant(int id, String name, String avatarSrc);
  Future<UULResponse<UserDTO>> deleteInhabitant(int id);
  bool hasToken();
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
  bool hasToken() => uulDio.currentToken().isNotEmpty;

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

  @override
  Future<UULResponse<UserDTO>> addUser(NewUserDTO dto) async {
    var response;
    try {
      response = await getDio().post("/api/users/new", data: dto.toJson());
      var result = UULResponse.fromResponse(response, UserDTO());
      if (result.isSuccess) {
        uulDio.updateToken(result.message);
      }
      return result;
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  @override
  Future<UULResponse<UserDTO>> changePassword(String newPwd, String oldPwd, String apartment, String login) async {
    var response;
    try {
      response = await uulDio.getInstance().post("/api/users/changepwd", data: {"newPwd": newPwd, "oldPwd": oldPwd, "login": login, "apartmentCode": apartment});
      var result = UULResponse.fromResponse(response, UserDTO());
      if (result.isSuccess) {
        uulDio.updateToken(result.message);
      }
      return result;
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  @override
  Future<UULResponse<SingleValueDTO>> deleteUser(NewUserDTO dto) async {
    var response;
    try {
      response = await uulDio.getInstance().post("/api/users/delete", data: dto.toJson());
      var result = UULResponse.fromResponse(response, SingleValueDTO());
      if (result.isSuccess) {
        uulDio.updateToken(result.message);
      }
      return result;
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  @override
  Future<UULResponse<UserDTO>> addInhabitant(String name, String avatarSrc) async {
    var response;
    try {
      response = await uulDio.getInstance().post("/api/habitants/add", data: {"name": name, "avatarSrc": avatarSrc});
      return UULResponse.fromResponse(response, UserDTO());
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  @override
  Future<UULResponse<UserDTO>> editInhabitant(int id, String name, String avatarSrc) async {
    var response;
    try {
      response = await uulDio.getInstance().post("/api/habitants/edit", data: {"id": id, "name": name, "avatarSrc": avatarSrc});
      return UULResponse.fromResponse(response, UserDTO());
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  @override
  Future<UULResponse<UserDTO>> deleteInhabitant(int id) async {
    var response;
    try {
      response = await uulDio.getInstance().post("/api/habitants/delete", data: {"id": id});
      return UULResponse.fromResponse(response, UserDTO());
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }
}
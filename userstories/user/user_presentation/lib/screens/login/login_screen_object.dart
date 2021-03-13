import 'package:common/common.dart';

class LoginScreenObject {
  String login = isProduction ? "" : "testLogin";
  String pwd = isProduction ? "" : "pwdTest";
  String apartmentCode = isProduction ? "" : "A1003";
}

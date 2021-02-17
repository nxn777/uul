import 'package:core/core.dart';

class AccountFormValidator {
  AccountFormValidator._();

  static StringValidator getApartmentValidator() {
    return _apartmentValidationErrorMessage;
  }

  static StringValidator getLoginValidator() {
    return _loginValidationErrorMessage;
  }

  static StringValidator getNameValidator() {
    return _nameValidationErrorMessage;
  }

  static StringValidator getPwdValidator() {
    return _pwdValidationErrorMessage;
  }

  static String fieldEqualityValidator(String value1, String value2) {
    return value1 == value2 ? null : "Values must be equal";
  }

  static String _loginValidationErrorMessage(String login) {
    return login.length > 3 ? null : "Should be at least 4 characters long";
  }

  static String _nameValidationErrorMessage(String login) {
    return login.isNotEmpty ? null : "Name should not be empty";
  }

  static String _pwdValidationErrorMessage(String pwd) {
    return pwd.length > 4 ? null : "Should be at least 5 characters long";
  }

  static String _apartmentValidationErrorMessage(String apartment) {
    return apartment.length == 5 ? null : "Should 5 characters long";
  }
}

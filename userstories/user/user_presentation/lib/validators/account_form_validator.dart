import 'package:core/core.dart';
import 'package:i18n/i18n.dart';

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
    return value1 == value2 ? null : "Values must be equal".i18n;
  }

  static String _loginValidationErrorMessage(String login) {
    return login.length > 3 ? null : "Should be at least %s characters long".i18n.fill([4]);
  }

  static String _nameValidationErrorMessage(String login) {
    return login.isNotEmpty ? null : "Name should not be empty".i18n;
  }

  static String _pwdValidationErrorMessage(String pwd) {
    return pwd.length > 4 ? null : "Should be at least %s characters long".i18n.fill([5]);
  }

  static String _apartmentValidationErrorMessage(String apartment) {
    return apartment.length == 5 ? null : "Should be exactly %s characters long".i18n.fill([5]);
  }
}

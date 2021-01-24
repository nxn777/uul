import 'package:UUL_Gym/common/validator/validators.dart';

class AccountFormValidator {
  AccountFormValidator._();

  static StringValidator getNameValidator() {
    return _nameValidationErrorMessage;
  }

  static StringValidator getPwdValidator() {
    return _pwdValidationErrorMessage;
  }

  static String _nameValidationErrorMessage(String name) {
    return name.isNotEmpty ? null : "Name should not be empty";
  }

  static String _pwdValidationErrorMessage(String pwd) {
    return pwd.length > 4 ? null : "Should be at least 5 characters long";
  }
}
import 'package:arch_components/arch_components.dart';
import 'package:flutter/widgets.dart';
import 'package:user_api/user_api.dart';

import 'login_screen_object.dart';
import 'package:i18n/i18n.dart';

class LoginViewModel extends ChangeNotifier with ViewStateField<LoginScreenObject> {
  final accountFormKey = GlobalKey<FormState>();
  final UserRepo _userRepo;

  @override
  ViewState<LoginScreenObject> viewState;

  LoginViewModel(this._userRepo) {
    viewState = ViewState(value: LoginScreenObject(), status: ViewStatus.IDLE);
  }

  void login(BuildContext context) async {
    if (!accountFormKey.currentState.validate()) {
      return;
    }
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    var isLoginSuccessful = await _userRepo.login(apartment: viewState.value.apartmentCode, login: viewState.value.login, pwd: viewState.value.pwd);
    if (isLoginSuccessful) {
      debugPrint("Login success");
      Navigator.of(context).pop(true);
    } else {
      debugPrint("Login failed");
      viewState = viewState.copyWith(
        status: ViewStatus.ERROR,
        error: ViewError(
          message: "Login failed".i18n,
          retry: () => login(context),
          canCancel: true,
        ),
      );
      notifyListeners();
    }
  }
}

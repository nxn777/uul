import 'package:arch_components/arch_components.dart';
import 'package:flutter/widgets.dart';
import 'package:user_api/user_api.dart';

import 'login_screen_object.dart';

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
    var result = await _userRepo.fetchAndCacheUsers(viewState.value.login, viewState.value.pwd);
    if (result.isNotEmpty) {
      await _userRepo.setActiveUserId(result.first.id);
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
  }
}

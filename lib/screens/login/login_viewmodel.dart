

import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/data/repo/user_repo.dart';
import 'package:UUL_Gym/screens/login/login_screen_object.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier with ViewStateField<LoginScreenObject> {
  final accountFormKey = GlobalKey<FormState>();
  final UserRepo _userRepo;

  @override
  ViewState<LoginScreenObject> viewState;

  LoginViewModel(this._userRepo) {
    viewState = ViewState(value: LoginScreenObject(), status: ViewStatus.IDLE);
  }

  void login(BuildContext context) async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    var result = await _userRepo.fetchAndCacheUsers(viewState.value.name, viewState.value.pwd);
    if (result.isNotEmpty) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
  }
}
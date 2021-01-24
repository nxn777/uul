

import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/screens/login/login_screen_object.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier with ViewStateField<LoginScreenObject> {
  final accountFormKey = GlobalKey<FormState>();

  @override
  ViewState<LoginScreenObject> viewState;

  LoginViewModel() {
    viewState = ViewState(value: LoginScreenObject(), status: ViewStatus.IDLE);
  }
}
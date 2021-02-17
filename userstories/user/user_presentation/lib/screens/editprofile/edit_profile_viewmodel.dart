import 'package:arch_components/arch_components.dart';
import 'package:flutter/foundation.dart';
import 'package:user_api/user_api.dart';
import 'package:user_presentation/screens/editprofile/edit_profile_screen_object.dart';

class EditProfileViewModel extends ChangeNotifier with ViewStateField<EditProfileScreenObject>, DefaultErrorResponseHandlers {
  String oldPwd = "";
  String newPwd = "";
  String newPwd2 = "";
  final UserRepo _userRepo;

  EditProfileViewModel(this._userRepo) {
    viewState = ViewState(value: EditProfileScreenObject(), status: ViewStatus.IDLE);
  }
}
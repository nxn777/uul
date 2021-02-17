import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:user_api/user_api.dart';
import 'package:user_presentation/screens/editprofile/edit_profile_screen_object.dart';

class EditProfileViewModel extends ChangeNotifier with ViewStateField<EditProfileScreenObject>, DefaultErrorResponseHandlers {
  final UserRepo _userRepo;
  final formKey = GlobalKey<FormState>();
  final BuildContext _context;
  EditProfileViewModel(this._context, this._userRepo) {
    viewState = ViewState(value: EditProfileScreenObject(), status: ViewStatus.LOADING);
  }

  void fetchData() async {
    (await _userRepo.getUser()).fold(
      onSuccess: (user) {
        viewState = ViewState(value: EditProfileScreenObject(user: user), status: ViewStatus.IDLE);
        notifyListeners();
      },
      onFailure: (response) => handleFailure(() => fetchData(), response),
    );
  }

  void deleteProfile(String pwd) async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    (await this._userRepo.deleteProfile(login: viewState.value.user.login, apartment: viewState.value.user.apartmentCode, password: pwd)).fold(
      onSuccess: (result) {
        Navigator.of(_context).pop(true);
      },
      onFailure: (response) => handleFailure(() => deleteProfile(pwd), response),
    );
  }

  void logout() {

  }

  void changePassword() {

  }
}
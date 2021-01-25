import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/data/repo/user_repo.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_screen_object.dart';
import 'package:flutter/foundation.dart';

class UserProfilesViewModel extends ChangeNotifier with ViewStateField<UserProfilesScreenObject> {
  final UserRepo _userRepo;

  ViewState<UserProfilesScreenObject> viewState;

  UserProfilesViewModel(this._userRepo) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

  void fetchData() async {
    var activeUser = _userRepo.getActiveOrFirstCachedUser();
    if (activeUser == null) {
      viewState = viewState.copyWith(status: ViewStatus.IDLE); // no user profiles stored
      notifyListeners();
      return;
    }
    var users = await _userRepo.fetchAndCacheUsers(activeUser.name, activeUser.pwdHash);
    var activeUserId = _userRepo.getActiveUserId();
    viewState = ViewState(value: UserProfilesScreenObject(currentUserId: activeUserId, activeUserId: activeUserId, allUsers: users), status: ViewStatus.IDLE);
    notifyListeners();
  }

  void changeCurrentUser(User user) {
    // user in the list was selected
  }

  void changeActiveUser(User user) {
    // star button was pressed
  }

  void onLoginResult(bool result) {
    if (result == true) {
      fetchData();
    }
  }
}
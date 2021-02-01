import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/data/repo/rules_repo.dart';
import 'package:UUL_Gym/data/repo/user_repo.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_screen_object.dart';
import 'package:flutter/foundation.dart';

class UserProfilesViewModel extends ChangeNotifier with ViewStateField<UserProfilesScreenObject> {
  final UserRepo _userRepo;
  final RulesRepo _rulesRepo;

  ViewState<UserProfilesScreenObject> viewState;

  UserProfilesViewModel(this._userRepo, this._rulesRepo) {
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
    var rules = await _rulesRepo.loadRules();
    var activeUserId = _userRepo.getActiveUserId();
    viewState = ViewState(
        value: UserProfilesScreenObject(
          currentUserId: activeUserId,
          activeUserId: activeUserId,
          allUsers: users,
          canAddMore: users.length < rules.usersPerApartment,
        ),
        status: ViewStatus.IDLE);
    notifyListeners();
  }

  void changeCurrentUser(User user) {
    // user in the list was selected
    viewState.value.currentUserId = user.id;
    notifyListeners();
  }

  void changeActiveUser(User user) {
    // star button was pressed
    viewState.value.activeUserId = user.id;
    notifyListeners();
  }

  void onUserActionResult(bool result) {
    if (result == true) {
      fetchData();
    }
  }
}

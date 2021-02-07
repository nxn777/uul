import 'package:flutter/foundation.dart';
import 'package:arch_components/arch_components.dart';
import 'user_profiles_screen_object.dart';
import 'package:user_api/user_api.dart';
import 'package:rules_api/rules_api.dart';
import 'package:core/core.dart';

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
    var activeUserId = _userRepo.getActiveUserId();
    (await _rulesRepo.loadRules()).fold(
      onSuccess: (rules) {
        viewState = ViewState(
            value: UserProfilesScreenObject(
              currentUserId: activeUserId,
              activeUserId: activeUserId,
              allUsers: users,
              canAddMore: users.length < rules.habitantsPerApartment,
            ),
            status: ViewStatus.IDLE);
        notifyListeners();
      },
      onFailure: (response) {
        print(this.toString() + ":" + response.message);
      },
    );
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

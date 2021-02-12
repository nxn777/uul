import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:rules_api/rules_api.dart';
import 'package:user_api/user_api.dart';

import 'user_profiles_screen_object.dart';

class UserProfilesViewModel extends ChangeNotifier with ViewStateField<UserProfilesScreenObject> {
  final UserRepo _userRepo;
  final RulesRepo _rulesRepo;

  ViewState<UserProfilesScreenObject> viewState;

  UserProfilesViewModel(this._userRepo, this._rulesRepo) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

  void _showNeedLogin() {
    viewState = ViewState(status: ViewStatus.IDLE); // no user profiles stored
    notifyListeners();
  }

  void _showNetworkError({String message}) {
    if (viewState.value != null) {
      viewState = viewState.copyWith(
        status: ViewStatus.ERROR,
        error: ViewError(
          message: message,
          retry: () => fetchData(),
          canCancel: true,
          cancel: () {
            viewState = viewState.copyWith(status: ViewStatus.IDLE, error: null);
            notifyListeners();
          },
        ),
      );
    } else {
      viewState = viewState.copyWith(
        status: ViewStatus.ERROR,
        error: ViewError(
          message: message,
          retry: () => fetchData(),
        ),
      );
    }
    notifyListeners();
  }

  void _showIdle(User user, Rules rules) async {
    int storedActiveInhabitantId = _userRepo.getActiveInhabitantId();
    int activeInhabitantId = storedActiveInhabitantId >=0 ? storedActiveInhabitantId : user.inhabitants.first.id;
    var so = UserProfilesScreenObject(
      currentInhabitantId: activeInhabitantId,
      activeInhabitantId: activeInhabitantId,
      user: user,
      canAddMore: user.inhabitants.length < rules.habitantsPerApartment,
    );
    viewState = viewState.copyWith(value: so, status: ViewStatus.IDLE, error: null);
    notifyListeners();
  }

  void fetchData() async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    var rulesTask = _rulesRepo.loadRules();
    (await _userRepo.getUser()).fold(
      onSuccess: (user) async {
        var rules = (await rulesTask).getOrNull();
        if (rules == null) {
          _showNetworkError();
          debugPrint("$this rules were not fetched");
          return;
        }
        _showIdle(user, rules);
        debugPrint("$this fetched ${user.login}");
      },
      onFailure: (response) {
        switch (response.code) {
          case -1:
            _showNetworkError();
            break;
          case 401:
            _showNeedLogin();
            break;
          default:
            _showNetworkError(message: response.message);
        }
        debugPrint("$this fetched ${response.message} ${response.code}");
      },
    );

    // var activeUser = _userRepo.getActiveOrFirstCachedUser();
    // if (activeUser == null) {
    //   viewState = viewState.copyWith(status: ViewStatus.IDLE); // no user profiles stored
    //   notifyListeners();
    //   return;
    // }
    // var users = await _userRepo.fetchAndCacheUsers(activeUser.name, activeUser.pwdHash);
    // var activeUserId = _userRepo.getActiveUserId();
    // (await _rulesRepo.loadRules()).fold(
    //   onSuccess: (rules) {
    //     viewState = ViewState(
    //         value: UserProfilesScreenObject(
    //           currentInhabitantId: activeUserId,
    //           activeInhabitantId: activeUserId,
    //           allUsers: users,
    //           canAddMore: users.length < rules.habitantsPerApartment,
    //         ),
    //         status: ViewStatus.IDLE);
    //     notifyListeners();
    //   },
    //   onFailure: (response) {
    //     print(this.toString() + ":" + response.message);
    //   },
    // );
  }

  void changeCurrentInhabitant(Inhabitant inhabitant) {
    // user in the list was selected
    viewState.value.currentInhabitantId = inhabitant.id;
    notifyListeners();
  }

  void changeActiveInhabitant(Inhabitant inhabitant) {
    // star button was pressed
    viewState.value.activeInhabitantId = inhabitant.id;
    notifyListeners();
  }

  void onUserActionResult(bool result) {
    if (result == true) {
      debugPrint("Should update user profiles screen");
      fetchData();
    }
  }
}

import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:rules_api/rules_api.dart';
import 'package:user_api/user_api.dart';

import 'user_profiles_screen_object.dart';

class UserProfilesViewModel extends ChangeNotifier with ViewStateField<UserProfilesScreenObject>, DefaultErrorResponseHandlers {
  final UserRepo _userRepo;
  final RulesRepo _rulesRepo;

  ViewState<UserProfilesScreenObject> viewState;

  UserProfilesViewModel(this._userRepo, this._rulesRepo) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

  @override
  void showNeedLogin() {
    viewState = ViewState(status: ViewStatus.IDLE); // no user profiles stored
    notifyListeners();
  }

  void _showIdle(User user, Rules rules) async {
    int storedActiveInhabitantId = _userRepo.getActiveInhabitantId();
    int storedCurrentInhabitantId = _userRepo.getCurrentInhabitantId();
    int activeInhabitantId = storedActiveInhabitantId >=0 ? storedActiveInhabitantId : user.inhabitants.first.id;
    int currentInhabitantId = storedCurrentInhabitantId >=0 ? storedCurrentInhabitantId : user.inhabitants.first.id;
    await _userRepo.setCurrentInhabitantId(activeInhabitantId);
    await _userRepo.setActiveInhabitantId(activeInhabitantId);
    var so = UserProfilesScreenObject(
      currentInhabitantId: currentInhabitantId,
      activeInhabitantId: activeInhabitantId,
      user: user,
      canAddMore: user.inhabitants.length < rules.habitantsPerApartment,
    );
    viewState = viewState.copyWith(value: so, status: ViewStatus.IDLE, error: null);
    notifyListeners();
  }

  void fetchData({bool fromPullRefresh = false}) async {
    if (!fromPullRefresh) {
      viewState = viewState.copyWith(status: ViewStatus.LOADING);
      notifyListeners();
    }
    var rulesTask = _rulesRepo.loadRules();
    (await _userRepo.getUser(forced: fromPullRefresh)).fold(
      onSuccess: (user) async {
        var rules = (await rulesTask).getOrNull();
        if (rules == null) {
          showNetworkError(() => fetchData());
          debugPrint("$this rules were not fetched");
          return;
        }
        _showIdle(user, rules);
        debugPrint("$this fetched ${user.login}");
      },
      onFailure: (response) => handleFailure(() => fetchData(), response),
    );
  }

  void changeCurrentInhabitant(Inhabitant inhabitant) async {
    // user in the list was selected
    await _userRepo.setCurrentInhabitantId(inhabitant.id);
    viewState.value.currentInhabitantId = inhabitant.id;
    notifyListeners();
  }

  void changeActiveInhabitant(Inhabitant inhabitant) async {
    // star button was pressed
    await _userRepo.setActiveInhabitantId(inhabitant.id);
    viewState.value.activeInhabitantId = inhabitant.id;
    notifyListeners();
  }


  void onUserActionResult(result) async {
    if (result is User) {
      (await _rulesRepo.loadRules()).fold(
        onSuccess: (rules) {
          _showIdle(result, rules);
        },
        onFailure: (response) => handleFailure(() => onUserActionResult(result), response),
      );
      debugPrint("Should update user profiles screen with newly added User");
      return;
    }
    if (result is bool && result == true) {
      debugPrint("Should update user profiles screen");
      fetchData();
    }
  }
}

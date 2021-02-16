import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:user_api/user_api.dart';
import 'package:user_presentation/common/inhabitant_viewmodel.dart';
import 'package:user_presentation/common/profile_mixins.dart';
import 'package:user_presentation/common/steps_viewmodel.dart';

import 'edit_inhabitant_screen_object.dart';

const int _FIRST_STEP = 0;

class EditInhabitantScreenViewModel extends StepsViewModel
    with ViewStateField<EditInhabitantScreenObject>, AvatarSelection, DefaultErrorResponseHandlers, InhabitantViewModel
    implements HasReviewInfo {
  final UserRepo _userRepo;
  final BuildContext _context;
  Inhabitant _inhabitant;
  ReviewInfo get reviewInfo => ReviewInfo(name, login, apartment, "Review and update", reviewMessage: "");
  @override
  String get applyButtonTitle => "Update";
  bool _shouldShowDeleteProfile = false;
  bool get shouldShowDeleteProfile => _shouldShowDeleteProfile;

  EditInhabitantScreenViewModel(this._context, this._userRepo) : super(_FIRST_STEP) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

  void fetchData() async {
    (await _userRepo.getUser()).fold(
      onSuccess: (user) {
        _inhabitant = _getInhabitantToEdit(user);
        if (_inhabitant == null) {
          viewState = viewState.copyWith(status: ViewStatus.ERROR, error: ViewError(retry: () => Navigator.of(_context).pop()));
          notifyListeners();
          return;
        }
        login = user.login;
        apartment = user.apartmentCode;
        name = _inhabitant.name;
        activeAvatarImage = _inhabitant.avatarSrc;
        _shouldShowDeleteProfile = true;//user.inhabitants.length == 1;
        viewState = ViewState(value: EditInhabitantScreenObject(), status: ViewStatus.IDLE);
        notifyListeners();
        markAllStepsVisited();
      },
      onFailure: (response) => handleFailure(() => fetchData(), response),
    );
  }

  @override
  void onComplete() async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    (await this._userRepo.editInhabitant(id: _inhabitant.id, name: name, avatarSrc: activeAvatarImage)).fold(
      onSuccess: (user) {
        Navigator.of(_context).pop(user);
      },
      onFailure: (response) => handleFailure(() => onComplete(), response),
    );
  }

  @override
  void onTotalStepsChange(int newValue) {
    markAllStepsVisited();
  }

  void deleteInhabitant() async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    (await this._userRepo.deleteInhabitant(_inhabitant.id)).fold(
      onSuccess: (user) async {
        await _userRepo.setCurrentInhabitantId(user.inhabitants.first.id);
        Navigator.of(_context).pop(user);
      },
      onFailure: (response) => handleFailure(() => deleteInhabitant(), response),
    );
  }

  void deleteProfile(String pwd) async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    (await this._userRepo.deleteProfile(login: login, apartment: apartment, password: pwd)).fold(
      onSuccess: (result) {
        Navigator.of(_context).pop(true);
      },
      onFailure: (response) => handleFailure(() => deleteProfile(pwd), response),
    );
  }

  Inhabitant _getInhabitantToEdit(User user) {
    int inhabitantId = _userRepo.getCurrentInhabitantId();
    debugPrint("InhabitantId to edit: $inhabitantId");
    if (inhabitantId < 0) {
      viewState = viewState.copyWith(status: ViewStatus.ERROR, error: ViewError(retry: () => Navigator.of(_context).pop()));
      notifyListeners();
      return null;
    }
    try {
      return user.inhabitants.firstWhere((element) => element.id == inhabitantId);
    } catch (e) {
      return null;
    }
  }

}

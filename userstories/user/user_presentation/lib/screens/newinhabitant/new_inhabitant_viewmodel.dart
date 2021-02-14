import 'package:arch_components/arch_components.dart';
import 'package:flutter/widgets.dart';
import 'package:user_api/user_api.dart';
import 'package:user_presentation/common/inhabitant_viewmodel.dart';
import 'package:user_presentation/common/profile_mixins.dart';
import 'package:user_presentation/common/steps_viewmodel.dart';
import 'package:user_presentation/screens/newinhabitant/new_inhabitant_screen_object.dart';

const int _FIRST_STEP = 0;

class NewInhabitantScreenViewModel extends StepsViewModel
    with ViewStateField<NewInhabitantScreenObject>, AvatarSelection, DefaultErrorResponseHandlers, InhabitantViewModel
    implements HasReviewInfo {
  final UserRepo _userRepo;
  final BuildContext _context;

  ReviewInfo get reviewInfo => ReviewInfo(name, login, apartment, "Review and create");

  NewInhabitantScreenViewModel(this._context, this._userRepo) : super(_FIRST_STEP) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

  void fetchData() async {
    (await _userRepo.getUser()).fold(
        onSuccess: (user) {
          login = user.login;
          apartment = user.apartmentCode;
          viewState = ViewState(value: NewInhabitantScreenObject(), status: ViewStatus.IDLE);
          notifyListeners();
        },
        onFailure: (response) => handleFailure(() => fetchData(), response));
  }

  @override
  void onComplete() async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    (await this._userRepo.addNewInhabitant(name: name, avatarSrc: activeAvatarImage)).fold(
      onSuccess: (user) {
        Navigator.of(_context).pop(user);
      },
      onFailure: (response) => handleFailure(() => onComplete(), response),
    );
  }
}

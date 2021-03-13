import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rules_api/rules_api.dart';
import 'package:user_api/user_api.dart';
import 'package:user_presentation/common/profile_mixins.dart';
import 'package:user_presentation/common/steps_viewmodel.dart';

import 'new_profile_screen_object.dart';
import 'package:i18n/i18n.dart';

const int _FIRST_STEP = 0;

// TODO use erasers on dependent fields when changing address parts
class NewProfileViewModel extends StepsViewModel with ViewStateField<NewProfileScreenObject>, DefaultErrorResponseHandlers, AvatarSelection implements HasReviewInfo {
  final UserRepo _userRepo;
  final RulesRepo _rulesRepo;
  final Function(User) onUserCreated;
  final formKey = GlobalKey<FormState>();
  Condo _condo;
  BuildContext _context;

  NewProfileViewModel(this._userRepo, this._rulesRepo, this._context, {@required this.onUserCreated}) : super(_FIRST_STEP) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

  String login = isProduction ? "" : "testLogin";
  String name = isProduction ? "" : "Test";
  String pwd = isProduction ? "" :"pwdTest";
  List<String> get towers => _condo.towers;
  String activeTower = "";
  List<String> get floors => _condo.getFloors(activeTower);
  String activeFloor = "";
  List<String> get doors => _condo.getDoors(activeTower, activeFloor);
  String activeDoor = "";
  String get apartmentCode => _condo.getApartmentCode(activeTower, activeFloor, activeDoor);
  ReviewInfo get reviewInfo => ReviewInfo(name, login, apartmentCode, "Review and create".i18n);
  User user;

  void fetchData() async {
    (await _rulesRepo.loadRules()).fold(onSuccess: (rules) {
      _condo = Condo(rules.buildings, rules.specialFloorTitles, rules.doorsPerFloor, rules.bannedApartments);
      viewState = ViewState(value: NewProfileScreenObject(), status: ViewStatus.IDLE);
      notifyListeners();
    }, onFailure: (response) {
      print(this.toString() + ":" + response.message);
    });
  }

  @override
  void onComplete() async {
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    (await this._userRepo.addNewProfile(login: login, name: name, password: pwd, apartment: apartmentCode, avatarSrc: activeAvatarImage)).fold(
      onSuccess: (user) {
        Navigator.of(_context).pop(user);
      },
      onFailure: (response) => handleFailure(() => onComplete(), response),
    );
  }

  void changeActiveTower(String tower) {
    this.activeTower = tower;
    this.activeFloor = "";
    notifyListeners();
  }

  void changeActiveFloor(String floor) {
    this.activeFloor = floor;
    this.activeDoor = "";
    notifyListeners();
  }

  void changeActiveDoor(String door) {
    this.activeDoor = door;
    notifyListeners();
  }

}

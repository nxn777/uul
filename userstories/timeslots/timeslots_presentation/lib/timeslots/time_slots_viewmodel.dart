import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:rules_api/rules_api.dart';
import 'package:timeslots_api/timeslots_api.dart';
import 'package:navigation/navigation.dart';
import 'package:user_api/user_api.dart';
import 'time_slots_screen_object.dart';
import 'package:i18n/i18n.dart';

class TimeSlotsViewModel extends ChangeNotifier with ViewStateField<TimeSlotsScreenObject>, DefaultErrorResponseHandlers {
  final GymRepo _gymRepo;
  final RulesRepo _rulesRepo;
  final ScheduleRepo _scheduleRepo;
  final UserRepo _userRepo;
  final DeepLinkCommandExecutor  _deepLinkCommandExecutor;
  ViewState<TimeSlotsScreenObject> viewState;

  TimeSlotsViewModel(this._userRepo, this._gymRepo, this._rulesRepo, this._scheduleRepo, this._deepLinkCommandExecutor) {
    viewState = ViewState<TimeSlotsScreenObject>(status: ViewStatus.LOADING);
  }

  bool isLoggedIn() => _userRepo.isLoggedIn();

  void fetchData({bool fromPullRefresh = false}) async {
    if (!fromPullRefresh) {
      viewState = viewState.copyWith(status: ViewStatus.LOADING);
      notifyListeners();
    }
    var currentWeek = Week.withDay(DateTime.now());
    var activeDate = DateTime.now();
    var currentDate = DateTime.now();
    var selectedGymId = _gymRepo.getSelectedGymId();
    var rulesResult = await _rulesRepo.loadRules();
    var scheduleResult = await _scheduleRepo.fetchSchedule(selectedGymId, activeDate);
    rulesResult.combineWith(scheduleResult).fold(
      onSuccess: (rulesAndSchedule) async {
        if (rulesAndSchedule.value1.gyms.isEmpty) {
          this.viewState = this.viewState.copyWith(status: ViewStatus.ERROR, error: ViewError(message: "No gyms set".i18n, retry: () => fetchData()));
          notifyListeners();
          return;
        }
        if (selectedGymId == 0) {
          selectedGymId = rulesAndSchedule.value1.gyms.first.id;
          _gymRepo.setSelectedGymId(selectedGymId);
          fetchData();
          return;
        }
        this.viewState = ViewState(
            value: TimeSlotsScreenObject(
                gyms: rulesAndSchedule.value1.gyms,
                activeGymId: selectedGymId,
                currentWeek: currentWeek,
                activeDate: activeDate,
                currentDate: currentDate,
                rules: rulesAndSchedule.value1,
                timeSlots: rulesAndSchedule.value2.timeSlots),
            status: ViewStatus.IDLE);
        notifyListeners();
      },
      onFailure: (response) => handleFailure(() => fetchData(), response),
    );
  }

  void changeActiveGym(Gym gym) {
    _gymRepo.setSelectedGymId(gym.id);
    this.viewState.value.activeGymId = gym.id;
    _updateTimeSlots();
  }

  void changeActiveDate(DateTime newDate) {
    this.viewState.value.activeDate = newDate;
    _updateTimeSlots();
  }

  void bookTimeSlot(TimeSlot timeSlot) async {
    if (isLoggedIn()) {
      viewState = viewState.copyWith(status: ViewStatus.LOADING);
      notifyListeners();
      int inhabitantId = _userRepo.getActiveInhabitantId();
      (await _scheduleRepo.bookTimeSlot(viewState.value.activeGymId, timeSlot.id, inhabitantId)).fold(
        onSuccess: (schedule) {
          viewState = viewState.copyWith(value: viewState.value.copyWith(schedule.timeSlots), status: ViewStatus.IDLE);
          notifyListeners();
        },
        onFailure: (response) => handleFailure(() =>bookTimeSlot(timeSlot), response),
      );
    } else {
      _deepLinkCommandExecutor.openTab(TabItem.USER_PROFILES);
    }
  }

  void _updateTimeSlots() async {
    this.viewState = this.viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    (await _scheduleRepo.fetchSchedule(this.viewState.value.activeGymId, this.viewState.value.activeDate)).fold(
      onSuccess: (schedule) {
        this.viewState = this.viewState.copyWith(status: ViewStatus.IDLE);
        this.viewState.value.timeSlots.clear();
        this.viewState.value.timeSlots.addAll(schedule.timeSlots);
        notifyListeners();
      },
      onFailure: (response) => handleFailure(() => _updateTimeSlots(), response),
    );
  }
}

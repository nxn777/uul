import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:rules_api/rules_api.dart';
import 'package:timeslots_api/timeslots_api.dart';
import 'package:navigation/navigation.dart';
import 'time_slots_screen_object.dart';

class TimeSlotsViewModel extends ChangeNotifier with ViewStateField<TimeSlotsScreenObject>, DefaultErrorResponseHandlers {
  final GymRepo _gymRepo;
  final RulesRepo _rulesRepo;
  final ScheduleRepo _scheduleRepo;
  final DeepLinkCommandExecutor  _deepLinkCommandExecutor;
  ViewState<TimeSlotsScreenObject> viewState;

  TimeSlotsViewModel(this._gymRepo, this._rulesRepo, this._scheduleRepo, this._deepLinkCommandExecutor) {
    viewState = ViewState<TimeSlotsScreenObject>(status: ViewStatus.LOADING);
  }

  void fetchData() async {
    var currentWeek = Week.withDay(DateTime.now());
    var activeDate = DateTime.now();
    var currentDate = DateTime.now();
    var selectedGymId = _gymRepo.getSelectedGymId();
    var rulesResult = await _rulesRepo.loadRules();
    var scheduleResult = await _scheduleRepo.fetchSchedule(selectedGymId, activeDate);
    rulesResult.combineWith(scheduleResult).fold(
      onSuccess: (rulesAndSchedule) async {
        if (rulesAndSchedule.value1.gyms.isEmpty) {
          this.viewState = this.viewState.copyWith(status: ViewStatus.ERROR, error: ViewError(message: "No gyms set", retry: () => fetchData()));
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
    viewState = viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    fetchData();
    _deepLinkCommandExecutor.openTab(TabItem.USER_PROFILES);
    _deepLinkCommandExecutor.executeNavCommand(TabItem.USER_PROFILES, (nav) => nav.pushNamed("/new_inhabitant"));
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

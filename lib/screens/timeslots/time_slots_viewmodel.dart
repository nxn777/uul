import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/data/repo/gym_repo.dart';
import 'package:UUL_Gym/data/repo/rules_repo.dart';
import 'package:UUL_Gym/data/repo/timeslots_repo.dart';
import 'package:UUL_Gym/models/gym.dart';
import 'package:UUL_Gym/models/week.dart';
import 'package:UUL_Gym/screens/timeslots/time_slots_screen_object.dart';
import 'package:flutter/widgets.dart';

class TimeSlotsViewModel extends ChangeNotifier with ViewStateField<TimeSlotsScreenObject> {
  final GymRepo _gymRepo;
  final RulesRepo _rulesRepo;
  final TimeSlotsRepo _timeSlotsRepo;
  ViewState<TimeSlotsScreenObject> viewState;

  TimeSlotsViewModel(this._gymRepo, this._rulesRepo, this._timeSlotsRepo) {
    viewState = ViewState<TimeSlotsScreenObject>(status: ViewStatus.LOADING);
  }

  void fetchData() async {
    var currentWeek = Week.withDay(DateTime.now());
    var activeDate = DateTime.now();
    var currentDate = DateTime.now();
    var gyms = _gymRepo.loadGyms();
    var rules = _rulesRepo.loadRules();
    var selectedGymId = _gymRepo.getSelectedGymId();
    var slots = _timeSlotsRepo.fetchTimeSlotsByDateTime(selectedGymId, activeDate);
    Future.wait([gyms, rules, slots]);
    this.viewState = ViewState(
        value: TimeSlotsScreenObject(
            gyms: await gyms, activeGymId: selectedGymId, currentWeek: currentWeek, activeDate: activeDate, currentDate: currentDate, rules: await rules, timeSlots: await slots),
        status: ViewStatus.IDLE);
    notifyListeners();
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

  void _updateTimeSlots() async {
    this.viewState = this.viewState.copyWith(status: ViewStatus.LOADING);
    notifyListeners();
    var slots = await _timeSlotsRepo.fetchTimeSlotsByDateTime(this.viewState.value.activeGymId, this.viewState.value.activeDate);
    this.viewState = this.viewState.copyWith(status: ViewStatus.IDLE);
    this.viewState.value.timeSlots.clear();
    this.viewState.value.timeSlots.addAll(slots);
    notifyListeners();
  }
}

import 'package:UUL_Gym/common/date_helpers.dart';
import 'package:UUL_Gym/models/gym.dart';
import 'package:UUL_Gym/models/rules.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:UUL_Gym/models/week.dart';

class TimeSlotsScreenObject {
  final List<Gym> gyms;
  int activeGymId;

  Gym get activeGym => gyms[activeGymId];
  final Week currentWeek;
  DateTime activeDate;
  final DateTime currentDate;
  final List<TimeSlot> timeSlots;
  final Rules rules;

  TimeSlotsScreenObject({this.gyms, this.activeGymId, this.currentWeek, this.activeDate, this.currentDate, this.timeSlots, this.rules});

  bool get isCurrentDateActive => DateHelpers.isTheSameDay(activeDate, currentDate);
}

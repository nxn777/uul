import 'package:core/core.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

class TimeSlotsScreenObject {
  final List<Gym> gyms;
  int activeGymId;

  Gym get activeGym => gyms.singleWhere((element) => element.id == activeGymId);
  final Week currentWeek;
  DateTime activeDate;
  final DateTime currentDate;
  final List<TimeSlot> timeSlots;
  final Rules rules;

  TimeSlotsScreenObject({
    @required this.gyms,
    @required this.activeGymId,
    @required this.currentWeek,
    @required this.activeDate,
    @required this.currentDate,
    @required this.timeSlots,
    @required this.rules,
  });

  bool get isCurrentDateActive => activeDate.isTheSameDay(currentDate);

  TimeSlotsScreenObject copyWith(List<TimeSlot> timeSlots) {
    return TimeSlotsScreenObject(
      gyms: this.gyms,
      activeGymId: this.activeGymId,
      currentWeek: this.currentWeek,
      currentDate: this.currentDate,
      activeDate: this.activeDate,
      rules: this.rules,
      timeSlots: timeSlots,
    );
  }
}

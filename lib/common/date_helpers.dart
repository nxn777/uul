import 'package:UUL_Gym/models/time_slot.dart';
import 'package:intl/intl.dart';

class DateHelpers {
  static bool isTheSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  static final DateFormat _timeSlotTimeFormatter = DateFormat.Hm();

  static String formatTimeSlotTitle(TimeSlot timeSlot) => "${_timeSlotTimeFormatter.format(timeSlot.start)} - ${_timeSlotTimeFormatter.format(timeSlot.end)}";
}

extension MapHelpers on DateTime {
  String toMapKey() => "${this.year}-${this.month}-${this.day}";
}

import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _timeSlotTimeFormatter = DateFormat.Hm();
  static final DateFormat _newsTimeFormatter = DateFormat.MMMMd().add_Hm();

  static String formatTimeSlotTitle(DateTime start, end) => "${_timeSlotTimeFormatter.format(start)} - ${_timeSlotTimeFormatter.format(end)}";
  static String formatNewsDateTime(DateTime dateTime) => "${_newsTimeFormatter.format(dateTime)}";
}

extension MapHelpers on DateTime {
  String toMapKey() => "${this.year}-${this.month}-${this.day}";
}

extension DateHelpers on DateTime {
  bool isTheSameDay(DateTime date2) {
    return this.year == date2.year && this.month == date2.month && this.day == date2.day;
  }
}

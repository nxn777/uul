class Week {
  final DateTime currentDate;
  final List<DateTime> days;
  final int count = 7;

  Week({this.currentDate, this.days});

  DateTime getWeekDayByDayNumber(int dayNumber) {
    return days[dayNumber - 1];
  }

  factory Week.withDay(DateTime baseDate) {
    var list = List<DateTime>(7);
    int currentWeekDay = baseDate.weekday - 1;
    list[currentWeekDay] = baseDate;
    for (int i = currentWeekDay - 1; i >= 0; i--) {
      var date = baseDate.subtract(Duration(days: currentWeekDay - i));
      list[i] = date;
    }
    for (int i = currentWeekDay + 1; i <= 6; i++) {
      var date = baseDate.add(Duration(days: i - currentWeekDay));
      list[i] = date;
    }
    return Week(currentDate: baseDate, days: List.unmodifiable(list));
  }
}

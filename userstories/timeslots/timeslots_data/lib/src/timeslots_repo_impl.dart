import 'dart:math';

import 'package:core/core.dart';
import 'package:extensions/extensions.dart';
import 'package:timeslots_api/timeslots_api.dart';

class DefaultTimeSlotsRepo implements TimeSlotsRepo {
  Future<List<TimeSlot>> fetchTimeSlotsByDateTime(int gymId, DateTime dateTime) => fetchTimeSlots(gymId, dateTime.year, dateTime.month, dateTime.day);

  Future<List<TimeSlot>> fetchTimeSlots(int gymId, int year, int month, int day) {
    var date = DateTime(year, month, day);
    return Future.delayed(Duration(seconds: 1), () => _generateTestData(date));
  }

  List<TimeSlot> _generateTestData(DateTime activeDate) =>
      List(20).mapIndexed((value, index) => TimeSlot(id: index, start: activeDate, end: activeDate.add(Duration(hours: 1)), occupiedBy: _generateUsers(Random().nextInt(5))));

  List<User> _generateUsers(int number) => List(number).mapIndexed((value, index) => User(login: "username #$index", apartmentCode: "C120${Random().nextInt(2)}"));
}

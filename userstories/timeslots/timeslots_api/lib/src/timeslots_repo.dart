import 'package:core/core.dart';

abstract class TimeSlotsRepo {
  Future<List<TimeSlot>> fetchTimeSlotsByDateTime(int gymId, DateTime dateTime);

  Future<List<TimeSlot>> fetchTimeSlots(int gymId, int year, int month, int day);
}
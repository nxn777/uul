import 'package:core/core.dart';

abstract class ScheduleRepo {
  Future<UULResult<Schedule>> fetchSchedule(int gymId, DateTime dateTime);
}

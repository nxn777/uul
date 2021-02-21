import 'package:caching/caching.dart';
import 'package:core/core.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:timeslots_api/timeslots_api.dart';

import 'apiclient/schedule_api_client.dart';
import 'apiclient/schedule_dtos.dart';

const String _SCHEDULE_KEY_BASE = "schedule";

class DefaultScheduleRepo implements ScheduleRepo {
  final ScheduleApiClient _apiClient;
  final KVStore _store;

  DefaultScheduleRepo(this._apiClient, this._store);

  Future<UULResult<Schedule>> fetchSchedule(int gymId, DateTime dateTime) => _fetchSchedule(gymId, dateTime.year, dateTime.month, dateTime.day);

  Future<UULResult<Schedule>> _fetchSchedule(int gymId, int year, int month, int day) {
    var cachingRequest =
        CachingRequest<Schedule, ScheduleDTO>("$_SCHEDULE_KEY_BASE$gymId$year$month$day", _store, networkCall: () => _apiClient.getTimeSlotsForDayAndGym(gymId, year, month, day));
    return cachingRequest.call(true, ScheduleDTO(), skipCaching: true);
  }
}

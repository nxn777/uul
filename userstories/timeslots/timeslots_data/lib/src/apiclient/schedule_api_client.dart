import 'package:rest/rest.dart';
import 'schedule_dtos.dart';

abstract class ScheduleApiClient {
  Future<UULResponse<ScheduleDTO>> getTimeSlotsForDay(int year, int month, int day);
  Future<UULResponse<ScheduleDTO>> getTimeSlotsForDayAndGym(int gymId, int year, int month, int day);
}

class DefaultScheduleApiClient implements ScheduleApiClient {
  final UULDio uulDio;

  DefaultScheduleApiClient(this.uulDio);

  @override
  Future<UULResponse<ScheduleDTO>> getTimeSlotsForDay(int year, int month, int day) async {
    var response;
    try {
      response = await getDio().get("/api/timeslots/$year/$month/$day");
      var result = UULResponse.fromResponse(response, ScheduleDTO());
      return result;
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  @override
  Future<UULResponse<ScheduleDTO>> getTimeSlotsForDayAndGym(int gymId, int year, int month, int day) async {
    var response;
    try {
      response = await getDio().get("/api/timeslots/$gymId/$year/$month/$day");
      var result = UULResponse.fromResponse(response, ScheduleDTO());
      return result;
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }
}
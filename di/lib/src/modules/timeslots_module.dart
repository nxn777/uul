import 'package:persistence_api/persistence_api.dart';
import 'package:rest/rest.dart';
import 'package:timeslots_api/timeslots_api.dart';
import 'package:timeslots_data/timeslots_data.dart';

class TimeSlotsModule {
  final KVStore _kvStore;
  final UULDio _uulDio;

  TimeSlotsModule(this._kvStore, this._uulDio);

  GymRepo createGymRepo() => DefaultGymRepo(_kvStore);
  ScheduleRepo createScheduleRepo() => DefaultScheduleRepo(DefaultScheduleApiClient(_uulDio), _kvStore);
}

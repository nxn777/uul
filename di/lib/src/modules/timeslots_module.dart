import 'package:persistence_api/persistence_api.dart';
import 'package:timeslots_api/timeslots_api.dart';
import 'package:timeslots_data/timeslots_data.dart';

class TimeSlotsModule {
  final KVStore _kvStore;

  TimeSlotsModule(this._kvStore);

  GymRepo createGymRepo() => DefaultGymRepo(_kvStore);
  TimeSlotsRepo createTimeSlotsRepo() => DefaultTimeSlotsRepo();
}
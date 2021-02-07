import 'package:core/core.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:timeslots_api/timeslots_api.dart';

const String _GYM_KEY = "selected_gym";

class DefaultGymRepo implements GymRepo {
  final KVStore _store;

  DefaultGymRepo(this._store);

  Future<List<Gym>> loadGyms() {
    return Future.value(Gym.getGyms());
  }

  int getSelectedGymId() => _store.getInteger(_GYM_KEY, 0);

  Future<bool> setSelectedGymId(int id) => _store.setInt(_GYM_KEY, id);
}

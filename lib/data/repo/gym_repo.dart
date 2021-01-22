import 'package:UUL_Gym/common/kv_store.dart';
import 'package:UUL_Gym/models/gym.dart';

const String _GYM_KEY = "selected_gym";
class GymRepo {
  final KVStore _store;

  GymRepo(this._store);

  Future<List<Gym>> loadGyms() {
    return Future.value(Gym.getGyms());
  }

  int getSelectedGymId() => _store.getInteger(_GYM_KEY, 0);

  Future<bool> setSelectedGymId(int id) => _store.setInt(_GYM_KEY, id);
}
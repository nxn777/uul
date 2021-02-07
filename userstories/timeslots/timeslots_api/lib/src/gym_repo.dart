import 'package:core/core.dart';

abstract class GymRepo {
  Future<List<Gym>> loadGyms();
  int getSelectedGymId();
  Future<bool> setSelectedGymId(int id);
}

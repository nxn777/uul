import 'package:UUL_Gym/common/has_title.dart';

// enum Gym { GymA, GymB }
//
// extension GymDesc on Gym {
//   String get title {
//     switch (this) {
//       case Gym.GymA:
//         return "Gym A";
//       case Gym.GymB:
//         return "Gym B";
//     }
//     return "Unknown";
//   }
// }
class Gym with HasTitle {
  static List<Gym> getGyms() => [Gym._(0, "Gym A"), Gym._(1, "Gym B")];

  final _title;
  final id;

  Gym._(this.id, this._title);

  @override
  String getTitle() => _title;
}

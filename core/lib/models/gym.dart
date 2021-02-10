import 'has_title.dart';
// TODO REMOVE, use rules
class Gym with HasTitle {
  static List<Gym> getGyms() => [Gym._(0, "Gym A"), Gym._(1, "Gym B")];

  final _title;
  final id;

  Gym._(this.id, this._title);

  @override
  String getTitle({bool raw = false}) => _title;
}

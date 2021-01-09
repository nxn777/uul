import 'package:UUL_Gym/common/has_title.dart';
import 'package:UUL_Gym/models/tower.dart';

class Floor with HasTitle {
  static List<Floor> getFloors(Tower tower) {
    if (tower.getTitle() == "A" || tower.getTitle() == "B") {
      return _addPH(_getFloors(9));
    } else {
      return _addPH(_getFloors(11));
    }
  }

  static List<Floor> _getFloors(int count) =>
      List(count).asMap().map((index, value) => MapEntry(index, Floor._(index, (index + 1).toString().padLeft(2, '0'), (index + 1).toString().padLeft(2, '0')))).values.toList();

  static List<Floor> _addPH(List<Floor> input) {
    input.add(Floor._(input.length, "PH", (input.length + 1).toString().padLeft(2, '0')));
    return input;
  }

  final _title;
  final _raw;
  final id;

  Floor._(this.id, this._title, this._raw);

  @override
  String getTitle({bool raw = false}) => raw ? _raw : _title;
}

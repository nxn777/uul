import 'package:UUL_Gym/common/has_title.dart';
import 'package:UUL_Gym/common/list_extensions.dart';

class Door with HasTitle {
  static List<Door> getDoor({int count = 8}) => List(count).mapIndexed((value, index) => Door._(index, (index + 1).toString().padLeft(2, '0')));

  final _title;
  final id;

  Door._(this.id, this._title);

  @override
  String getTitle({bool raw = false}) => _title;
}

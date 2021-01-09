import 'package:UUL_Gym/common/has_title.dart';

class Tower with HasTitle {
  static List<Tower> getTowers() => [Tower._(0, "A"), Tower._(1, "B"), Tower._(2, "C"), Tower._(3, "D")];

  final _title;
  final id;

  Tower._(this.id, this._title);

  @override
  String getTitle() => _title;
}

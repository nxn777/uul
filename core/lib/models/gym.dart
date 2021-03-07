import 'has_title.dart';
import 'package:i18n/i18n.dart';

class Gym implements HasTitle {
  final bool isOpen;
  final String name;
  final int id;
  Gym(this.id, this.name, this.isOpen);

  @override
  String getTitle({bool raw = false}) {
    return "Gym %s".i18n.fill([name]);
  }
}

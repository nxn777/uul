import 'package:flutter/cupertino.dart';

class Inhabitant {
  final int id;
  final String name;
  final String avatarSrc;

  Inhabitant({@required this.id, @required this.name, this.avatarSrc});
}
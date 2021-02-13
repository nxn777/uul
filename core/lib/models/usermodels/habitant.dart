import 'package:flutter/cupertino.dart';

class Inhabitant {
  final int id;
  final String name;
  final String avatarSrc;
  final String lastVisit = null;

  Inhabitant({@required this.id, @required this.name, this.avatarSrc});

  String getLastVisitFormatted() {
    return "Last gym booking: ${lastVisit == null ? "Never" : lastVisit}";
  }
}
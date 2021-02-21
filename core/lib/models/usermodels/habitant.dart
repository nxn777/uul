import 'package:flutter/cupertino.dart';

class Inhabitant {
  final int id;
  final String name;
  final String avatarSrc;
  final String apartmentCode;
  final String lastVisit = null;

  Inhabitant({@required this.id, @required this.name, @required this.apartmentCode, this.avatarSrc});

  String getLastVisitFormatted() {
    return "Last gym booking: ${lastVisit == null ? "Never" : lastVisit}";
  }
}
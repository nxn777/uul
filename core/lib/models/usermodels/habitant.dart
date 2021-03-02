import 'package:flutter/cupertino.dart';

class Inhabitant {
  final int id;
  final String name;
  final String avatarSrc;
  final String apartmentCode;
  final String lastVisit;

  Inhabitant({@required this.id, @required this.name, @required this.apartmentCode, @required this.lastVisit, this.avatarSrc});

  String getLastVisitFormatted() {
    return "Last gym booking: ${lastVisit == null ? "Never" : lastVisit}";
  }
}
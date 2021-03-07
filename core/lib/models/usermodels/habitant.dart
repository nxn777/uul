import 'package:flutter/cupertino.dart';
import 'package:i18n/i18n.dart';

class Inhabitant {
  final int id;
  final String name;
  final String avatarSrc;
  final String apartmentCode;
  final String lastVisit;

  Inhabitant({@required this.id, @required this.name, @required this.apartmentCode, @required this.lastVisit, this.avatarSrc});

  String getLastVisitFormatted() {
    return "Last gym booking: %s".i18n.fill([lastVisit == null ? "Never".i18n : lastVisit]);
  }
}
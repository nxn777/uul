import 'package:core/models/usermodels/habitant.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String login;
  final String apartmentCode;
  final bool isActivated;
  final List<Inhabitant> inhabitants;

  User({@required this.login, @required this.apartmentCode, this.isActivated, this.inhabitants});
}

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class UserProfilesScreenObject {
  int currentInhabitantId;
  int activeInhabitantId;
  final User user;
  bool canAddMore;

  UserProfilesScreenObject({@required this.currentInhabitantId, @required this.activeInhabitantId, @required this.user, @required this.canAddMore});

  Inhabitant get currentInhabitant => user.inhabitants.firstWhere((element) => element.id == currentInhabitantId);

  List<Inhabitant> get notCurrentInhabitants => user.inhabitants.where((element) => element.id != currentInhabitantId).toList();
}

import 'package:UUL_Gym/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProfilesScreenObject {
  int currentUserId;
  int activeUserId;
  final List<User> allUsers;

  UserProfilesScreenObject({@required this.currentUserId, @required this.activeUserId, @required this.allUsers});

  User get currentUser => allUsers.firstWhere((element) => element.id == currentUserId, orElse: () => null);
  List<User> get notCurrentUsers => allUsers.where((element) => element.id != currentUserId);
}
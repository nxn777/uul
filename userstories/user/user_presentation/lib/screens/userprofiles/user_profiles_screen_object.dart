import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class UserProfilesScreenObject {
  int currentUserId;
  int activeUserId;
  final List<User> allUsers;
  bool canAddMore;

  UserProfilesScreenObject({@required this.currentUserId, @required this.activeUserId, @required this.allUsers, @required this.canAddMore});

  User get currentUser => allUsers.firstWhere((element) => element.id == currentUserId);

  List<User> get notCurrentUsers => allUsers.where((element) => element.id != currentUserId).toList();
}

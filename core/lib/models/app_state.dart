import 'package:flutter/widgets.dart';

import 'user.dart';

class AppState extends ChangeNotifier {
  final List<User> availableUsers = [];

  int activeUserId = -1;

  void addUser(User user) {
    availableUsers.add(user);
    activeUserId = availableUsers.length - 1;
    notifyListeners();
  }
}

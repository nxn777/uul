import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:UUL_Gym/screens/user_profiles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilesTabRoutes extends TabRoutes {
  static const String root = '/';
  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilder> routeBuilders(BuildContext context) {
    return {ProfilesTabRoutes.root: (context) => UserProfilesScreen()};
  }
}

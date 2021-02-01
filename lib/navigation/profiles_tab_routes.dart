import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:UUL_Gym/screens/login/login_screen.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_screen.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilesTabRoutes extends TabRoutes {
  static const String root = '/';
  static const String newProfile = "/new_profile";
  static const String login = "/login";
  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilder> routeBuilders(BuildContext context) {
    return {
      ProfilesTabRoutes.root: (context) => UserProfilesScreen(
            onNewProfileTap: () {
              return push(newProfile, context, true);
            },
            onLoginTap: () {
              return push(login, context, true);
            },
          ),
      ProfilesTabRoutes.newProfile: (context) => NewProfileScreen(),
      ProfilesTabRoutes.login: (context) => LoginScreen()
    };
  }
}

import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_presentation/user_presentation.dart';

class ProfilesTabRoutes extends TabRoutes {
  static const String root = '/';
  static const String newProfile = "/new_profile";
  static const String newInhabitant = "/new_inhabitant";
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
            onNewInhabitantTap: () {
              return push(newInhabitant, context, true);
            },
            onLoginTap: () {
              return push(login, context, true);
            },
          ),
      ProfilesTabRoutes.newProfile: (context) => NewProfileScreen(),
      ProfilesTabRoutes.login: (context) => LoginScreen(),
      ProfilesTabRoutes.newInhabitant: (context) => NewInhabitantScreen()
    };
  }
}

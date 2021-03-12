import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_presentation/user_presentation.dart';

class ProfilesTabRoutes extends TabRoutes {
  static const String root = '/';
  static const String newProfile = "/new_profile";
  static const String editProfile = "/edit_profile";
  static const String newInhabitant = "/new_inhabitant";
  static const String editInhabitant = "/edit_inhabitant";
  static const String login = "/login";

  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilderWrapper> routeBuilders(BuildContext context, {data}) {
    return {
      ProfilesTabRoutes.root: (_) => (context) => UserProfilesScreen(
            onNewProfileTap: () {
              return push(newProfile, context, true, true);
            },
            onNewInhabitantTap: () {
              return push(newInhabitant, context, true, true);
            },
            onLoginTap: () {
              return push(login, context, true, true);
            },
            onEditInhabitantTap: () {
              return push(editInhabitant, context, true, true);
            },
            onEditProfileTap: () {
              return push(editProfile, context, true, true);
            },
          ),
      ProfilesTabRoutes.newProfile: (_) => (context) => NewProfileScreen(),
      ProfilesTabRoutes.login: (_) => (context) => LoginScreen(),
      ProfilesTabRoutes.newInhabitant: (_) => (context) => NewInhabitantScreen(),
      ProfilesTabRoutes.editInhabitant: (_) => (context) => EditInhabitantScreen(),
      ProfilesTabRoutes.editProfile: (_) => (context) => EditProfileScreen(),
    };
  }
}

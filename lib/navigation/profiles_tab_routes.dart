import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:UUL_Gym/screens/user_profiles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'file:///C:/local/flutter/UUL_Gym/lib/screens/newprofile/add_new_profile_screen.dart';

class ProfilesTabRoutes extends TabRoutes {
  static const String root = '/';
  static const String newProfile = "/new_profile";
  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilder> routeBuilders(BuildContext context) {
    return {
      ProfilesTabRoutes.root: (context) => UserProfilesScreen(
            onNewProfileTap: () {
              push(newProfile, context, true);
            },
          ),
      ProfilesTabRoutes.newProfile: (context) => AddNewProfileScreen()
    };
  }
}
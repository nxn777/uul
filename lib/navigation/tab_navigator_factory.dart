import 'package:UUL_Gym/navigation/news_tab_routes.dart';
import 'package:UUL_Gym/navigation/profiles_tab_routes.dart';
import 'package:UUL_Gym/navigation/schedule_tab_routes.dart';
import 'package:UUL_Gym/navigation/tab_navigator.dart';
import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

class TabNavigatorFactory {
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  TabNavigatorFactory({@required this.navigatorKeys});

  TabNavigator getTabNavigator(TabItem tabItem) {
    TabRoutes tabRoutes;
    switch (tabItem) {
      case TabItem.NEWS:
        tabRoutes = NewsTabRoutes();
        break;
      case TabItem.SCHEDULE:
        tabRoutes = ScheduleTabRoutes();
        break;
      case TabItem.USER_PROFILES:
        tabRoutes = ProfilesTabRoutes();
        break;
    }
    return TabNavigator(navigatorKey: navigatorKeys[tabItem], tabItem: tabItem, tabRoutes: tabRoutes);
  }
}

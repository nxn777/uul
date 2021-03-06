import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({@required this.navigatorKey, @required this.tabItem, @required this.tabRoutes});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final TabRoutes tabRoutes;

  @override
  Widget build(BuildContext context) {
    final routeBuilders = tabRoutes.routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: tabRoutes.defaultRoute,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](null)(context),
        );
      },
    );
  }
}

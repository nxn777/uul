import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({@required this.navigatorKey, @required this.tabItem, @required this.tabRoutes});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final TabRoutes tabRoutes;

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with AutomaticKeepAliveClientMixin<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final routeBuilders = widget.tabRoutes.routeBuilders(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: widget.tabRoutes.defaultRoute,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](null)(context),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

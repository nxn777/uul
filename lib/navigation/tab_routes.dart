import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class TabRoutes {
  String defaultRoute;

  Map<String, WidgetBuilder> routeBuilders(BuildContext context);

  Future push(String screen, BuildContext context, bool hideNavBar) {
    return Navigator.of(context, rootNavigator: hideNavBar).push(
      MaterialPageRoute(
        builder: (context) => routeBuilders(context)[screen](context),
      ),
    );
  }
}

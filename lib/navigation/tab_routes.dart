import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class TabRoutes {
  String defaultRoute;

  Map<String, WidgetBuilder> routeBuilders(BuildContext context);

  void push(String screen,BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders(context)[screen](context),
      ),
    );
  }
}

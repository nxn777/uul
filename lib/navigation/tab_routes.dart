import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class TabRoutes {
  String defaultRoute;

  Map<String, WidgetBuilder> routeBuilders(BuildContext context);

  // void push(BuildContext context) {
  //   var routeBuilders = routeBuilders(context);
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
  //     ),
  //   );
  // }
}

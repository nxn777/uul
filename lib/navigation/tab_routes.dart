import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class TabRoutes {
  String defaultRoute;

  Map<String, WidgetBuilderWrapper> routeBuilders(BuildContext context);

  Future push(String screen, BuildContext context, bool hideNavBar, {dynamic screenParam}) {
    return Navigator.of(context, rootNavigator: hideNavBar).push(
      MaterialPageRoute(
        builder: (context) => routeBuilders(context)[screen].call(screenParam).call(context),
      ),
    );
  }
}

typedef WidgetBuilderWrapper = WidgetBuilder Function(dynamic screenParam);
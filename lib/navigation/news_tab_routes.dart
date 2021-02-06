import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_presentation/screens/news_screen.dart';

class NewsTabRoutes extends TabRoutes {
  static const String root = '/';
  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilder> routeBuilders(BuildContext context) {
    return {NewsTabRoutes.root: (context) => NewsScreen()};
  }
}

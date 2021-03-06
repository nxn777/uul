import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_presentation/news_presentation.dart';
import 'package:news_presentation/screens/news_screen.dart';

class NewsTabRoutes extends TabRoutes {
  static const String root = '/';
  static const String details = '/details';
  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilderWrapper> routeBuilders(BuildContext context) {
    return {
      NewsTabRoutes.root: (_) => (context) => NewsScreen(
        onNewsTap: (news) {
          return push(NewsTabRoutes.details, context, true, screenParam: news);
        },
      ),
      NewsTabRoutes.details: (news) => (context) => NewsDetailScreen(news),
    };
  }
}

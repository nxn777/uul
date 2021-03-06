import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'news_screen_builder.dart';
import 'news_screen_viewmodel.dart';

class NewsScreen extends StatelessWidget with ViewStateScreen<NewsScreenViewModel> {
  @override
  NewsScreenViewModel Function(BuildContext p1) vmCreator() => NewsScreenBuilder.buildAndStartVM;

  @override
  Widget buildIdleState(NewsScreenViewModel viewModel, BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _getScreenChildren(context, viewModel, false),
        );
      } else {
        return ListView(
          children: _getScreenChildren(context, viewModel, true),
        );
      }
    });
  }

  List<Widget> _getScreenChildren(BuildContext context, NewsScreenViewModel viewModel, bool insideListView) {
    var so = viewModel.viewState.value;
    return [
      ScreenTitle("News"),
      insideListView
          ? NewsList(
              news: so.newsPaper.news,
              insideListView: insideListView,
            )
          : Expanded(
              child: NewsList(
                news: so.newsPaper.news,
                insideListView: insideListView,
              ),
            ),
    ];
  }
}

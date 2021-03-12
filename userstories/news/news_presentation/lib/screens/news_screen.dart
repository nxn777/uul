import 'package:arch_components/arch_components.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'package:i18n/i18n.dart';
import 'news_screen_builder.dart';
import 'news_screen_viewmodel.dart';

class NewsScreen extends StatelessWidget with ViewStateScreen<NewsScreenViewModel> {
  final Future Function(News) onNewsTap;

  NewsScreen({this.onNewsTap});

  @override
  NewsScreenViewModel Function(BuildContext p1) vmCreator() => NewsScreenBuilder.buildAndStartVM;

  @override
  Widget buildIdleState(NewsScreenViewModel viewModel, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.fetchData(fromPullRefresh: true),
      child: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _getScreenChildren(context, viewModel, false),
          );
        } else {
          return ListView(
            physics: ClampingScrollPhysics(),
            children: _getScreenChildren(context, viewModel, true),
          );
        }
      }),
    );
  }

  List<Widget> _getScreenChildren(BuildContext context, NewsScreenViewModel viewModel, bool insideListView) {
    var so = viewModel.viewState.value;
    return [
      ScreenTitle("News".i18n, backgroundColor: Colors.white, hasRoundedCorners: true,),
      insideListView
          ? NewsList(
              news: so.newsPaper.news,
              insideListView: insideListView,
              onTap: onNewsTap,
            )
          : Expanded(
              child: NewsList(
                news: so.newsPaper.news,
                insideListView: insideListView,
                onTap: onNewsTap,
              ),
            ),
    ];
  }
}

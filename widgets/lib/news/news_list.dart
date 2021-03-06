import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'news_tile.dart';


class NewsList extends StatelessWidget {
  final bool insideListView;
  final List<News> news;

  NewsList({this.insideListView = false, @required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => NewsTile(news[index]),
      itemCount: news.length,
      shrinkWrap: insideListView ? true : false,
      physics: insideListView ? ClampingScrollPhysics() : null,
    );
  }
}

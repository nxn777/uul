import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'news_tile.dart';


class NewsList extends StatelessWidget {
  final bool insideListView;
  final List<News> news;
  final void Function(News) onTap;

  NewsList({this.insideListView = false, @required this.news, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => NewsTile(news[index], onTap: onTap,),
      itemCount: news.length,
      shrinkWrap: insideListView ? true : false,
      physics: insideListView ? ClampingScrollPhysics() : null,
    );
  }
}

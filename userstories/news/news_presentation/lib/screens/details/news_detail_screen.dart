import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:extensions/extensions.dart';
import 'package:linkable/linkable.dart';
import 'package:widgets/widgets.dart';

class NewsDetailScreen extends StatelessWidget {
  final News _news;

  NewsDetailScreen(this._news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            NewsDetailHeader(_news),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
              child: Text(
                _news.title,
                style: kSubtitleActiveTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
              child: Linkable(
                text: _news.content,
                style: kRegularTextContentActiveTextStyle,
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
              child: Text(DateFormatter.createNewsDateFormat(context).format(_news.modifiedAt)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
              child: Text(
                _news.author,
                style: kRegularInactiveTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

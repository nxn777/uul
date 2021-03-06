import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:extensions/extensions.dart';
class NewsDetailHeader extends StatelessWidget {
  final News news;

  NewsDetailHeader(this.news);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
      child: Row(
        children: [
          Expanded(
            child: Text(
              news.type.getName(),
              style: kPageTitleTextStyle,
            ),
          ),

          Container(
            width: kSpacingXLarge,
            height: kSpacingXLarge,
            child: Center(
              child: FaIcon(
                news.type.getIcon(),
                color: news.type.getIconColor(),
                size: kSpacingXLarge,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:extensions/extensions.dart';
import 'package:i18n/i18n.dart';

import 'screen_title.dart';

class NewsDetailHeader extends StatelessWidget with BackButtonChooser {
  final News news;
  final Set<TargetPlatform> hasBackButtonIn;
  final bool hasBackText;
  NewsDetailHeader(this.news, {this.hasBackButtonIn, this.hasBackText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
      child: Row(
        children: getChildren(
          context,
          hasBackButtonIn,
          hasBackText,
          additionalWidgets: [
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
      ),
    );
  }
}

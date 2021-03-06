import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:extensions/extensions.dart';

class NewsTile extends StatelessWidget {
  final News news;
  final void Function(News) onTap;
  NewsTile(this.news, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(kSpacingMedium, kSpacingXSmallPlus, kSpacingMedium, kSpacingXSmallPlus),
      child: InkWell(
        onTap: () {
          this.onTap(news);
        },
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
              child: Container(
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
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: kSpacingMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, kSpacingSmall),
                    child: Text(
                      news.title,
                      style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "By: ${news.author}",
                    style: kCaptionInactiveTextStyle,
                  ),
                  SizedBox(
                    height: kSpacingSmall,
                  ),
                  Text(
                    "Last modified at: ${DateFormatter.formatNewsDateTime(news.modifiedAt)}",
                    style: kRegularActiveTextStyle,
                  ),
                  SizedBox(
                    height: kSpacingMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kSpacingMedium),
              child: FaIcon(
                FontAwesomeIcons.angleRight,
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: kBackgroundColor, borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
    );
  }
}

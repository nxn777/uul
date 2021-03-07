import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:extensions/extensions.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  final DateFormat newsDateFormat;
  final News news;
  final void Function(News) onTap;
  NewsTile(this.news, this.newsDateFormat, {this.onTap});

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
                    "By: %s".i18n.fill([news.author]),
                    style: kRegularInactiveSecondaryTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: kSpacingSmall,
                  ),
                  Text(
                    "Last modified at: %s".i18n.fill([newsDateFormat.format(news.modifiedAt)]),
                    style: kRegularInactiveSecondaryTextStyle,
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

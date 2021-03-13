import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ScreenTitleArrow { BACK, DOWN }

class ScreenTitle extends StatelessWidget with BackButtonChooser {
  final String title;
  final Set<TargetPlatform> hasBackButtonIn;
  final bool hasBackText;
  final Color backgroundColor;
  final bool hasRoundedCorners;
  final ScreenTitleArrow arrow;
  final bool adjustHeightForStatusBar;
  ScreenTitle(
    this.title, {
    this.hasBackButtonIn,
    this.hasBackText = false,
    this.backgroundColor,
    this.hasRoundedCorners = false,
    this.arrow = ScreenTitleArrow.BACK,
    this.adjustHeightForStatusBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return backgroundColor == null
        ? getContent(context)
        : Container(
            color: hasRoundedCorners ? null : Colors.white,
            decoration: hasRoundedCorners
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(kLargeBorderRadius),
                      bottomRight: Radius.circular(kLargeBorderRadius),
                    ),
                  )
                : null,
            child: getContent(context),
          );
  }

  Padding getContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
      child: Row(
        children: getChildren(
          context,
          hasBackButtonIn,
          hasBackText,
          arrow,
          additionalWidgets: [
            Text(
              title,
              style: kPageTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

mixin BackButtonChooser {
  Widget getBackButton(BuildContext context, ScreenTitleArrow arrow) {
    var icon = (isAndroid(context)) ? (Icons.arrow_back) : (Icons.arrow_back_ios_rounded);
    icon = arrow == ScreenTitleArrow.BACK ? icon : Icons.keyboard_arrow_down_sharp;
    return FaIcon(
      icon,
      size: kSpacingLarge,
      color: kAccentColor,
    );
  }

  List<Widget> getChildren(
      BuildContext context, Set<TargetPlatform> hasBackButtonIn, hasBackText, ScreenTitleArrow arrow,
      {List<Widget> additionalWidgets}) {
    List<Widget> result = [];
    if (hasBackButtonIn != null && hasBackButtonIn.contains(Theme.of(context).platform)) {
      result.add(TextButton.icon(
        onPressed: () => Navigator.of(context).pop(),
        icon: getBackButton(context, arrow),
        label: Text(
          hasBackText ? "Back".i18n : "",
          style: kRegularActiveLinkTextStyle,
        ),
      ));
    }
    if (additionalWidgets != null) {
      result.addAll(additionalWidgets);
    }
    return result;
  }
}

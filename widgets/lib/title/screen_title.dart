import 'dart:ui';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenTitle extends StatelessWidget with BackButtonChooser {
  final String title;
  final Set<TargetPlatform> hasBackButtonIn;
  final bool hasBackText;
  ScreenTitle(this.title, {this.hasBackButtonIn, this.hasBackText = false});

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
  Widget getBackButton(BuildContext context) {
    var icon = (Theme.of(context).platform == TargetPlatform.iOS) ? Icons.arrow_back_ios_rounded : Icons.arrow_back;
    return FaIcon(
      icon,
      size: kSpacingLarge,
      color: kAccentColor,
    );
  }

  List<Widget> getChildren(
      BuildContext context, Set<TargetPlatform> hasBackButtonIn, hasBackText, {List<Widget> additionalWidgets}) {
    List<Widget> result = [];
    if (hasBackButtonIn != null && hasBackButtonIn.contains(Theme.of(context).platform)) {
      result.add(TextButton.icon(
        onPressed: () => Navigator.of(context).pop(),
        icon: getBackButton(context),
        label: Text(
          hasBackText ? "Back".i18n : "",
          style: kRegularActiveLinkTextStyle,
        ),
      ));
    }
    if (additionalWidgets != null) { result.addAll(additionalWidgets); }
    return result;
  }
}

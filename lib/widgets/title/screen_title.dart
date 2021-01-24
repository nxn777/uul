import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  ScreenTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
      child: Text(
        title,
        style: kPageTitleTextStyle,
      ),
    );
  }
}

import 'package:common/common.dart';
import 'package:flutter/material.dart';

const kRegularTextSize = 12.0;
const kCaptionTextSize = 16.0;
const kPageTitleTextSize = 32.0;
const kSubTitleTextSize = 24.0;

const kSpacingMedium = 16.0;
const kSpacingXMedium = 12.0;
const kSpacingSmall = 8.0;
const kSpacingXSmall = 4.0;
const kSpacingXXSmall = 2.0;
const kSpacingXSmallPlus = 6.0;
const kSpacingLarge = 24.0;
const kSpacingXLarge = 32.0;
const kSpacingXXLarge = 48.0;
const kSpacingHuge = 64.0;

const kDefaultBorderRadius = 8.0;
const kMediumBorderRadius = 16.0;
const kLargeBorderRadius = 24.0;
const kXLargeBorderRadius = 32.0;

const _kBottomNavBarHeight = 60.0;
const _kBottomNavBarHeightIOS = 90.0;

double getBottomNavBarHeight(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return _kBottomNavBarHeightIOS;
  }
  return _kBottomNavBarHeight;
}
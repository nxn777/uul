import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:flutter/material.dart';

enum TabItem { NEWS, SCHEDULE, USER_PROFILES }

const Map<TabItem, String> tabName = {TabItem.NEWS: "News", TabItem.SCHEDULE: "Schedule", TabItem.USER_PROFILES: "Profiles"};

const Map<TabItem, Color> activeTabColor = {
  TabItem.NEWS: kAccentColor,
  TabItem.SCHEDULE: kAccentColor,
  TabItem.USER_PROFILES: kAccentColor,
};

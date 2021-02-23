import 'package:flutter/material.dart';

enum TabItem { NEWS, SCHEDULE, USER_PROFILES }

const Map<TabItem, String> tabName = {TabItem.NEWS: "News", TabItem.SCHEDULE: "Schedule", TabItem.USER_PROFILES: "Profiles"};

const Map<TabItem, Color> activeTabColor = {
  TabItem.NEWS: Colors.black,
  TabItem.SCHEDULE: Colors.black,
  TabItem.USER_PROFILES: Colors.black,
};

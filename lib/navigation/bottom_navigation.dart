import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'tabs.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});
  final _tabs = [TabItem.NEWS, TabItem.SCHEDULE, TabItem.USER_PROFILES];
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(kLargeBorderRadius), topLeft: Radius.circular(kLargeBorderRadius)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kLargeBorderRadius),
          topRight: Radius.circular(kLargeBorderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColoredBox(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getIndicators(),
              ),
            ),
            BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.white,
              items: _tabs.map((tab) => _buildItem(tab)).toList(),
              onTap: (index) => onSelectTab(
                TabItem.values[index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: FaIcon(
        _getTabIcon(tabItem),
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  IconData _getTabIcon(TabItem item) {
    IconData icon;
    switch (item) {
      case TabItem.NEWS:
        icon = FontAwesomeIcons.newspaper;
        break;
      case TabItem.SCHEDULE:
        icon = FontAwesomeIcons.list;
        break;
      case TabItem.USER_PROFILES:
        icon = FontAwesomeIcons.user;
        break;
    }
    return icon;
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }

  List<Widget> _getIndicators() => _tabs
      .map((tab) => Container(
            height: kSpacingXSmall,
            child: SizedBox(
              width: kSpacingXLarge,
              height: kSpacingXSmall,
            ),
            decoration: BoxDecoration(
              color: currentTab == tab ? kAccentColor : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ))
      .toList();
}

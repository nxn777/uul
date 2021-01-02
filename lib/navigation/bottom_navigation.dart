import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'tabs.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(kLargeBorderRadius), topLeft: Radius.circular(kLargeBorderRadius)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kLargeBorderRadius),
          topRight: Radius.circular(kLargeBorderRadius),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          items: [
            _buildItem(TabItem.NEWS),
            _buildItem(TabItem.SCHEDULE),
            _buildItem(TabItem.USER_PROFILES),
          ],
          onTap: (index) => onSelectTab(
            TabItem.values[index],
          ),
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
}

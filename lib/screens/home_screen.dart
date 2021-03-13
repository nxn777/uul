import 'package:UUL_Gym/navigation/bottom_navigation.dart';
import 'package:UUL_Gym/navigation/tab_navigator_factory.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  final DeepLinkDepRegisterer deepLinkDepRegisterer;

  HomeScreen(this.deepLinkDepRegisterer);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentTab = TabItem.NEWS;
  static final _navigatorKeys = {
    TabItem.NEWS: GlobalKey<NavigatorState>(),
    TabItem.SCHEDULE: GlobalKey<NavigatorState>(),
    TabItem.USER_PROFILES: GlobalKey<NavigatorState>(),
  };
  TabNavigatorFactory _tabNavigatorFactory = TabNavigatorFactory(navigatorKeys: _navigatorKeys);

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    widget.deepLinkDepRegisterer.registerTabSwitcher(_selectTab);
    widget.deepLinkDepRegisterer.registerNavKeys(_navigatorKeys);
    return ColoredStatusBar(
      child: WillPopScope(
        onWillPop: () async => !await _navigatorKeys[_currentTab].currentState.maybePop(),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            extendBody: true,
            body: Stack(children: <Widget>[
              _buildOffstageNavigator(TabItem.NEWS),
              _buildOffstageNavigator(TabItem.SCHEDULE),
              _buildOffstageNavigator(TabItem.USER_PROFILES),
            ]),
            backgroundColor: kWindowBackgroundColor,
            bottomNavigationBar: BottomNavigation(
              currentTab: _currentTab,
              onSelectTab: _selectTab,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: _tabNavigatorFactory.getTabNavigator(tabItem),
    );
  }
}

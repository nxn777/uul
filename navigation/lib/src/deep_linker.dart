import 'package:flutter/widgets.dart';

import '../navigation.dart';

abstract class DeepLinkCommandExecutor {
  void openTab(TabItem tabItem);
  void executeNavCommand(TabItem tabItem, Function(NavigatorState) navigatorCommand);
}

abstract class DeepLinkDepRegisterer {
  void registerTabSwitcher(void Function(TabItem) switcher);
  void registerNavKeys(Map<TabItem, GlobalKey<NavigatorState>> navKeys);
}

class DeepLinkProcessor implements DeepLinkDepRegisterer, DeepLinkCommandExecutor {
  Map<TabItem, GlobalKey<NavigatorState>> _navKeys;
  void Function(TabItem p1) _switcher;

  @override
  void executeNavCommand(TabItem tabItem, Function(NavigatorState) navigatorCommand) {
    navigatorCommand(Navigator.of(_navKeys[tabItem].currentContext));
  }

  @override
  void openTab(TabItem tabItem) {
    _switcher.call(tabItem);
  }

  @override
  void registerTabSwitcher(void Function(TabItem p1) switcher) {
    this._switcher = switcher;
  }

  @override
  void registerNavKeys(Map<TabItem, GlobalKey<NavigatorState>> navKeys) {
    _navKeys = navKeys;
  }

}
import 'package:di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'news_screen_viewmodel.dart';

class NewsScreenBuilder {

  NewsScreenBuilder._();

  static NewsScreenViewModel buildAndStartVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var newsRepo = globalDependencies.dependenciesProvider.newsModule.createNewsRepo();
    var vm = NewsScreenViewModel(newsRepo);
    vm.fetchData();
    return vm;
  }
}
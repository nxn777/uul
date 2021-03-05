import 'package:arch_components/arch_components.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'news_screen_builder.dart';
import 'news_screen_viewmodel.dart';

class NewsScreen extends StatelessWidget with ViewStateScreen<NewsScreenViewModel> {
  @override
  NewsScreenViewModel Function(BuildContext p1) vmCreator() => NewsScreenBuilder.buildAndStartVM;
  
  @override
  Widget buildIdleState(NewsScreenViewModel viewModel, BuildContext context) {
    // TODO: implement buildIdleState
    throw UnimplementedError();
  }

}

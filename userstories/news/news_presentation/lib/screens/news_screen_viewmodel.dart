import 'package:arch_components/arch_components.dart';
import 'package:flutter/widgets.dart';
import 'package:news_api/news_api.dart';

import 'news_screen_object.dart';

class NewsScreenViewModel extends ChangeNotifier with ViewStateField<NewsScreenObject>, DefaultErrorResponseHandlers {
  NewsRepo _newsRepo;

  NewsScreenViewModel(this._newsRepo) {
    viewState = ViewState(status: ViewStatus.LOADING);
  }

  void fetchData({bool fromPullRefresh = false}) async {
    if (!fromPullRefresh) {
      viewState = viewState.copyWith(status: ViewStatus.LOADING);
      notifyListeners();
    }
    (await _newsRepo.fetchNews()).fold(
      onSuccess: (newsPaper) {
        var so = NewsScreenObject(newsPaper);
        viewState = viewState.copyWith(value: so, status: ViewStatus.IDLE);
        notifyListeners();
      },
      onFailure: (response) => handleFailure(() => fetchData(), response),
    );
  }
}
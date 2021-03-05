import 'package:caching/caching.dart';
import 'package:core/models/news.dart';
import 'package:core/models/result.dart';
import 'package:news_api/news_api.dart';
import 'package:news_data/src/apiclient/news_api_client.dart';
import 'package:news_data/src/apiclient/news_dtos.dart';
import 'package:persistence_api/persistence_api.dart';

const String _NEWS_KEY = "news_key";
class DefaultNewsRepo implements NewsRepo {
  final KVStore _store;
  final NewsApiClient _apiClient;

  DefaultNewsRepo(this._store, this._apiClient);

  @override
  Future<UULResult<NewsPaper>> fetchNews() {
    var cachingRequest = CachingRequest(_NEWS_KEY, _store, networkCall: () => _apiClient.fetchNewsPaper());
    return cachingRequest.call(true, NewsPaperDTO(), skipCaching: true);
  }

}
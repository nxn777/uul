import 'package:persistence_api/persistence_api.dart';
import 'package:rest/rest.dart';
import 'package:news_api/news_api.dart';
import 'package:news_data/news_data.dart';

class NewsModule {
  final KVStore _kvStore;
  final UULDio _uulDio;

  NewsModule(this._kvStore, this._uulDio);

  NewsRepo createNewsRepo() => DefaultNewsRepo(_kvStore, DefaultNewsApiClient(_uulDio));
}
import 'package:core/models/news.dart';
import 'package:core/models/result.dart';
import 'package:news_api/news_api.dart';

class DefaultNewsRepo implements NewsRepo {
  @override
  Future<UULResult<News>> fetchNews() {
    // TODO: implement fetchNews
    throw UnimplementedError();
  }

}
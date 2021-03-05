import 'package:core/core.dart';

abstract class NewsRepo {
  Future<UULResult<News>> fetchNews();
}
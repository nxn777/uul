import 'package:core/core.dart';

abstract class NewsRepo {
  Future<UULResult<NewsPaper>> fetchNews();
}
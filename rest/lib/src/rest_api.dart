
import 'dio_factory.dart';
import 'package:dio/dio.dart';

Dio getDio() => _DioHolder.getInstance();

class _DioHolder {
  _DioHolder._();
  static Dio _instance;

  static Dio getInstance() {
    if (_instance == null) {
      _instance = createDio();
    }
    return _instance;
  }
}

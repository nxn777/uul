import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:common/common.dart';

const String _deVBaseUrl = "https://192.168.100.8:5001";
const String _prodUrl = _deVBaseUrl;

final String _kBaseUrl = isProduction ? _prodUrl : _deVBaseUrl;

final Map<String, String> kBaseHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

Dio getDio() => _DioHolder.getInstance();

class _DioHolder {
  _DioHolder._();
  static Dio _instance;

  static Dio getInstance() {
    if (_instance == null) {
      _instance = _getDio();
    }
    return _instance;
  }

  static Dio _getDio() {
    Dio dio;
    if (isProduction) {
      dio = Dio();
    } else {
      dio = new Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        const charlesIp = String.fromEnvironment('CHARLES_PROXY_IP', defaultValue: null);
        if (charlesIp != null) {
          client.findProxy = (uri) => "PROXY $charlesIp:8888;";
          debugPrint('#CharlesProxyEnabled at $charlesIp:8888');
        }
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    dio.options.baseUrl = _kBaseUrl;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    dio.options.responseType = ResponseType.plain;
    return dio;
  }
}
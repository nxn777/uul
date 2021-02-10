import 'dart:io';

import 'package:common/common.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String _deVBaseUrl = "https://192.168.100.8:5001";
const String _prodUrl = _deVBaseUrl;

final String _kBaseUrl = isProduction ? _prodUrl : _deVBaseUrl;

final Map<String, String> kBaseHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

Dio createDio() {
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

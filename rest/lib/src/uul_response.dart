import 'dart:convert';

import 'package:dio/dio.dart';

mixin HasFromJson {
  populateFromJson(dynamic jsonRaw);
}

class UULResponse<T extends HasFromJson> {
  bool _isSuccess;
  String _message;
  T _data;
  String _rawData;

  bool get isSuccess => _isSuccess;
  String get message => _message;
  T get data => _data;
  String get rawData => _rawData;

  UULResponse.fromCachedData(String raw, T dummy) {
    _rawData = raw;
    final json = jsonDecode(_rawData);
    _isSuccess = json["success"];
    _message = json["message"];
    dummy.populateFromJson(json["data"]);
    _data = dummy;
  }

  UULResponse.fromResponse(Response response, T dummy) {
    if (response.statusCode == 401) {
      _isSuccess = false;
      _message = "Unauthorized";
      _data = null;
      _rawData = null;
      return;
    }
    if (response.statusCode == 200) {
      _rawData = response.data.toString();
      final json = jsonDecode(_rawData);
      _isSuccess = json["success"];
      _message = json["message"];
      dummy.populateFromJson(json["data"]);
      _data = dummy;
    } else {
      _isSuccess = false;
      _message = response.statusMessage;
      _data = null;
      _rawData = null;
      return;
    }
  }
}

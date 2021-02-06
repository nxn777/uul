import 'dart:convert';

import 'package:dio/dio.dart';

mixin HasFromJson {
  populateFromJson(dynamic jsonRaw);
}

class UULResponse<T extends HasFromJson> {
  bool _isSuccess;
  String _message;
  T _data;

  bool get isSuccess => _isSuccess;
  String get message => _message;
  T get data => _data;

  UULResponse(Response response, T dummy) {
    if (response.statusCode == 401) {
      _isSuccess = false;
      _message = "Unauthorized";
      _data = null;
      return;
    }
    if (response.statusCode == 200) {
      final json = jsonDecode(response.data.toString());
      _isSuccess = json["success"];
      _message = json["message"];
      dummy.populateFromJson(json["data"]);
      _data = dummy;
    } else {
      _isSuccess = false;
      _message = response.statusMessage;
      _data = null;
      return;
    }
  }
}
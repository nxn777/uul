import 'dart:convert';
import 'package:i18n/i18n.dart';
import 'package:dio/dio.dart';


abstract class HasFromJson {
  populateFromJson(dynamic jsonRaw);
}

abstract class HasMapToDomain<D> extends HasFromJson {
  D mapToDomain();
}

class UULResponse<T extends HasFromJson> {
  bool _isSuccess;
  String _message;
  T _data;
  String _rawData;
  int _code;

  bool get isSuccess => _isSuccess;
  String get message => _message;
  T get data => _data;
  String get rawData => _rawData;
  int get code => _code;

  UULResponse.fromCachedData(String raw, T dummy) {
    _rawData = raw;
    final json = jsonDecode(_rawData);
    _isSuccess = json["success"];
    _message = json["message"];
    dummy.populateFromJson(json["data"]);
    _data = dummy;
    _code = 0;
  }

  UULResponse.fromResponse(Response response, T dummy) {
    if (response.statusCode == 401) {
      _isSuccess = false;
      _message = "Unauthorized".i18n;
      _data = null;
      _rawData = null;
      return;
    }
    if (response.statusCode == 200) {
      _rawData = response.data.toString();
      final json = jsonDecode(_rawData);
      _isSuccess = json["success"];
      _code =  json["code"];
      _message = json["message"];
      if (json["data"] != null) {
        dummy.populateFromJson(json["data"]);
        _data = dummy;
      } else {
        _data = null;
      }
    } else {
      _isSuccess = false;
      _data = null;
      _rawData = null;
    }
  }

  UULResponse.fromException(Exception e) {
    if (e is DioError) {
      _code = e.response?.statusCode ?? -1;
      _message = e.response?.statusMessage ?? "Network error".i18n;
      _data = null;
      _isSuccess = false;
      return;
    }
    _code = -1;
    _isSuccess = false;
    _message = e.toString();
    _data = null;
    _rawData = null;
  }

  static Future<UULResponse> fromCall(Future<Response> Function() source, HasFromJson dummy) async {
    Response response;
    try {
      response = await source.call();
      return UULResponse.fromResponse(response, dummy);
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

  UULResponse.fromSyncCall(Response Function() source, T dummy) {
    Response response;
    try {
      response =  source.call();
      UULResponse.fromResponse(response, dummy);
    } catch (e) {
      UULResponse.fromException(e);
    }
  }
}

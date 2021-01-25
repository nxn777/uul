import 'dart:convert';
import 'dart:io';

import 'package:UUL_Gym/models/appartment.dart';

class User {
  int _id;
  String _name;
  String _pwdHash;
  Appartment _appartment;
  String _avatarImageSrc;
  int get id => _id;
  bool _isActivated;
  String get name => _name;
  String get pwdHash => _pwdHash;

  Appartment get apartment => _appartment;

  String get avatarImageSrc => _avatarImageSrc;
  bool get isActivated => _isActivated;

  User({int id, String name, String pwdHash, Appartment appartment, String avatarImageSrc, bool isActivated}) {
    _id = id;
    _name = name;
    _appartment = appartment;
    _avatarImageSrc = avatarImageSrc;
    _isActivated = isActivated;
    _pwdHash = pwdHash;
  }

  User.fromJson(dynamic jsonRaw) {
    final json = jsonDecode(jsonRaw.toString());
    _id = json["id"];
    _name = json["name"];
    _pwdHash = json["pwdHash"];
    _appartment = Appartment.fromJson(json["appartment"]);
    _isActivated = json["isActivated"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["pwdHash"] = _pwdHash;
    map["isActivated"] = _isActivated;
    map["appartment"] = _appartment.toJson();
    return map;
  }
}

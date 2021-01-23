import 'package:UUL_Gym/models/appartment.dart';

class User {
  int _id;
  String _name;
  Appartment _appartment;
  String _avatarImageSrc;
  int get id => _id;
  bool _isActivated;
  String get name => _name;

  Appartment get apartment => _appartment;

  String get avatarImageSrc => _avatarImageSrc;
  bool get isActivated => _isActivated;

  User({int id, String name, Appartment appartment, String avatarImageSrc, isActivated}) {
    _id = id;
    _name = name;
    _appartment = appartment;
    _avatarImageSrc = avatarImageSrc;
    _isActivated = isActivated;
  }

  User.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _appartment = Appartment.fromJson(json["appartment"]);
    _isActivated = json["isActivated"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["appartment"] = _appartment.toJson();
    return map;
  }
}

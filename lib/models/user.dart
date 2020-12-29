import 'package:UUL_Gym/models/appartment.dart';

class User {
  int _id;
  String _name;
  Appartment _appartment;

  int get id => _id;

  String get name => _name;

  Appartment get apartment => _appartment;

  User({int id, String name, Appartment appartment}) {
    _id = id;
    _name = name;
    _appartment = appartment;
  }

  User.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _appartment = Appartment.fromJson(json["appartment"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}
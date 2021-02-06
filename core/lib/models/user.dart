import 'dart:convert';

class User {
  int _id;
  String _name;
  String _pwdHash;
  String _apartmentCode;
  String _avatarImageSrc;
  bool _isActivated;

  int get id => _id;
  String get name => _name;
  String get pwdHash => _pwdHash;
  String get avatarImageSrc => _avatarImageSrc;
  bool get isActivated => _isActivated;
  String get apartmentCode => _apartmentCode;

  User({int id, String name, String pwdHash, String apartmentCode, String avatarImageSrc, bool isActivated}) {
    _id = id;
    _name = name;
    _avatarImageSrc = avatarImageSrc;
    _isActivated = isActivated;
    _pwdHash = pwdHash;
    _apartmentCode = apartmentCode;
  }

  User.fromJson(dynamic jsonRaw) {
    final json = jsonDecode(jsonRaw.toString());
    _id = json["id"];
    _name = json["name"];
    _pwdHash = json["pwd"];
    _apartmentCode = json["apartmentCode"];
    _isActivated = json["isActivated"];
    _avatarImageSrc = json["avatarSrc"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["pwd"] = _pwdHash;
    map["isActivated"] = _isActivated;
    map["apartmentCode"] = _apartmentCode;
    map["avatarSrc"] = _avatarImageSrc;
    return map;
  }
}

/// id : 9103
/// code : "C0101"

class Appartment {
  int _id;
  String _code;

  int get id => _id;

  String get code => _code;

  Appartment({int id, String code}) {
    _id = id;
    _code = code;
  }

  Appartment.fromJson(dynamic json) {
    _id = json["id"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["code"] = _code;
    return map;
  }
}

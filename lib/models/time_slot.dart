import 'package:UUL_Gym/models/user.dart';

/// id : 152
/// start : "2020-12-22T11:00:00"
/// end : "2020-12-22T12:00:00"
/// occupiedBy : null

class TimeSlot {
  int _id;
  String _start;
  String _end;
  List<User> _occupiedBy;

  int get id => _id;
  String get start => _start;
  String get end => _end;
  List<User> get occupiedBy => _occupiedBy;

  TimeSlot({
    int id,
    String start,
    String end,
    List<User> occupiedBy}){
    _id = id;
    _start = start;
    _end = end;
    _occupiedBy = occupiedBy;
  }

  TimeSlot.fromJson(dynamic json) {
    _id = json["id"];
    _start = json["start"];
    _end = json["end"];
    if (json["occupiedBy"] != null) {
      _occupiedBy = [];
      json["occupiedBy"].forEach((v) {
        _occupiedBy.add(User.fromJson(v));
      });
    }
  }

  Map<String, User> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["start"] = _start;
    map["end"] = _end;
    if (_occupiedBy != null) {
      map["occupiedBy"] = _occupiedBy.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
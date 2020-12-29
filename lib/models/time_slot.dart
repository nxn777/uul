import 'package:UUL_Gym/models/user.dart';

/// id : 152
/// start : "2020-12-22T11:00:00"
/// end : "2020-12-22T12:00:00"
/// occupiedBy : null

class TimeSlot {
  int _id;
  DateTime _start;
  DateTime _end;
  List<User> _occupiedBy;

  int get id => _id;
  DateTime get start => _start;
  DateTime get end => _end;
  List<User> get occupiedBy => _occupiedBy;

  TimeSlot({
    int id,
    DateTime start,
    DateTime end,
    List<User> occupiedBy}){
    _id = id;
    _start = start;
    _end = end;
    _occupiedBy = occupiedBy;
  }

  TimeSlot.fromJson(dynamic json) {
    _id = json["id"];
    _start = DateTime.parse(json["start"]);
    _end = DateTime.parse(json["end"]);
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
    map["start"] = _start.toIso8601String();
    map["end"] = _end.toIso8601String();
    if (_occupiedBy != null) {
      map["occupiedBy"] = _occupiedBy.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
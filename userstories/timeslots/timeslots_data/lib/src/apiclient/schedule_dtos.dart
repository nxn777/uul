import 'package:core/core.dart';
import 'package:rest/rest.dart';

class ScheduleDTO implements HasFromJson, HasMapToDomain<Schedule> {
  List<TimeSlotDTO> timeSlots;

  ScheduleDTO({this.timeSlots});

  @override
  Schedule mapToDomain() {
    return Schedule(timeSlots.map((e) => e.mapToDomain()).toList());
  }

  @override
  populateFromJson(jsonRaw) {
    timeSlots = jsonRaw['timeSlots'] != null ? (jsonRaw['timeSlots'] as List).map((e) => TimeSlotDTO.fromJson(e)).toList() : [];
  }
}

class TimeSlotDTO implements HasFromJson, HasMapToDomain<TimeSlot> {
  String end;
  String gym;
  int id;
  List<InhabitantDTO> occupiedBy;
  String start;

  TimeSlotDTO({this.end, this.gym, this.id, this.occupiedBy, this.start});

  factory TimeSlotDTO.fromJson(Map<String, dynamic> json) {
    return TimeSlotDTO(
      end: json['end'],
      gym: json['gym'],
      id: json['id'],
      occupiedBy: json['occupiedBy'] != null ? (json['occupiedBy'] as List).map((i) => InhabitantDTO.fromJson(i)).toList() : [],
      start: json['start'],
    );
  }

  @override
  populateFromJson(json) {
    end = json['end'];
    gym = json['gym'];
    id = json['id'];
    occupiedBy = json['occupiedBy'] != null ? (json['occupiedBy'] as List).map((i) => InhabitantDTO.fromJson(i)).toList() : [];
    start = json['start'];
  }

  @override
  TimeSlot mapToDomain() {
    return TimeSlot(id, DateTime.tryParse(start).toLocal(), DateTime.tryParse(end).toLocal(), occupiedBy.map((e) => e.mapToDomain()).toList());
  }
}

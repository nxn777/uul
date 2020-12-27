import 'package:UUL_Gym/models/appartment.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:UUL_Gym/models/week.dart';
import 'package:UUL_Gym/models/gym.dart';
import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier {
  final List<Appartment> appartments = [];
  final List<User> availableUsers = [];
  final Map<String, List<TimeSlot>> timeSlots = new Map();
  DateTime activeDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  Week currentWeek = Week.withDay(DateTime.now());
  Gym activeGym = Gym.GymA;

  void changeActiveDate(DateTime newDate) {
    this.activeDate = newDate;
    notifyListeners();
  }

  void changeCurrentDate(DateTime newDate) {
    this.currentDate = newDate;
    this.currentWeek = Week.withDay(newDate);
    notifyListeners();
  }

  void updateTimeSlots(String date, List<TimeSlot> timeSlots) {
    this.timeSlots[date] = timeSlots;
    notifyListeners();
  }

  void changeActiveGym(Gym gym) {
    this.activeGym = gym;
    notifyListeners();
  }

  List<TimeSlot> getCurrentDateTimeSlots() {
    return timeSlots[activeDate] ?? _generateTestData(); //List.empty();
  }

  List<TimeSlot> _generateTestData() => List(20)
      .asMap()
      .map((index, value) => MapEntry(index, TimeSlot(id: index, start: index.toString() + " " + activeDate.toIso8601String(), end: "end", occupiedBy: List.empty())))
      .values
      .toList();
}

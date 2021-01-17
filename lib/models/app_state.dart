import 'dart:math';

import 'package:UUL_Gym/common/date_helpers.dart';
import 'package:UUL_Gym/models/appartment.dart';
import 'package:UUL_Gym/models/gym.dart';
import 'package:UUL_Gym/models/rules.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/models/week.dart';
import 'package:flutter/cupertino.dart';
import 'package:UUL_Gym/common/list_extensions.dart';

class AppState extends ChangeNotifier {
  //final List<Appartment> appartments = [];
  final List<User> availableUsers = [];
  final Map<String, List<TimeSlot>> timeSlots = new Map();
  DateTime activeDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  Week currentWeek = Week.withDay(DateTime.now());
  final List<Gym> gyms = Gym.getGyms();
  int activeGymId = 0;
  int activeUserId = -1;

  Gym get activeGym => gyms[activeGymId];

  Rules rules = Rules();

  bool get isCurrentDateActive => DateHelpers.isTheSameDay(activeDate, currentDate);

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
    this.activeGymId = gym.id;
    notifyListeners();
  }

  List<TimeSlot> getCurrentDateTimeSlots() {
    return timeSlots[activeDate] ?? _generateTestData(); //List.empty();
  }

  void addUser(User user) {
    availableUsers.add(user);
    activeUserId = availableUsers.length - 1;
    notifyListeners();
  }

  List<TimeSlot> _generateTestData() =>
      List(20).mapIndexed((value, index) => TimeSlot(id: index, start: activeDate, end: activeDate.add(Duration(hours: 1)), occupiedBy: _generateUsers(Random().nextInt(5))));

  List<User> _generateUsers(int number) =>
      List(number).mapIndexed((value, index) => User(id: index, name: "username #$index", appartment: Appartment(id: index, code: "C120${Random().nextInt(2)}")));
}

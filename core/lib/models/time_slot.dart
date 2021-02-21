import 'package:core/core.dart';

class TimeSlot {
  final int id;
  final DateTime start;
  final DateTime end;
  final List<Inhabitant> occupiedBy;

  TimeSlot(this.id, this.start, this.end, this.occupiedBy);
}

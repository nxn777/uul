import 'file:///C:/local/flutter/UUL_Gym/extensions/lib/src/list_extensions.dart';

class Condo {
  final Map<String, int> _buildings;
  final Map<String, String> _specialFloorTitles;
  final int _doorsPerFloor;
  final Set<String> _excludedDoors;

  List<String> _towers;
  List<String> get towers => _towers;

  Condo(this._buildings, this._specialFloorTitles, this._doorsPerFloor, this._excludedDoors) {
    var _buildingKeys = _buildings.keys.toList();
    _buildingKeys.sort();
    _towers = _buildingKeys;
  }

  List<String> getFloors(String tower) {
    var count = _buildings[tower] ?? 0;
    return List(count).mapIndexed((_, index) => _getFloorTitle(tower, index + 1));
  }

  List<String> getDoors(String tower, String floor) {
    var result = List<String>();
    for (var i = 0; i < _doorsPerFloor; ++i) {
      var elem = (i + 1).toString().padLeft(2, '0');
      var fullNumber = "$tower$floor$elem";
      if (!_excludedDoors.contains(fullNumber)) {
        result.add(elem);
      }
    }
    return result;
  }

  String _getFloorTitle(String tower, int floor) {
    var specialTitle = _specialFloorTitles["$tower$floor"];
    if (specialTitle != null) {
      return specialTitle;
    }
    return floor.toString().padLeft(2, '0');
  }

  String getApartmentCode(String tower, floor, door) {
    var setOfCustomTitleValues = _specialFloorTitles.values.toSet();
    if (setOfCustomTitleValues.contains(floor)) {
      var entries = _specialFloorTitles.entries.where((element) => element.key.startsWith(tower) && element.value == floor);
      if (entries.length == 1) {
        return entries.first.key + door;
      }
    }
    return tower + floor + door;
  }
}
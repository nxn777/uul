const defaultBuilding = {"A": 10, "B": 10, "C": 12, "D": 12};
const defaultSpecialFloors = {"A10": "PH", "B10": "PH", "C12": "PH", "D12": "PH"};
const Set<String> defaultBannedApartments = {};

class Rules {
  final version;
  final int personsPerTimeSlot;
  final int habitantsPerApartment;
  final Map<String, int> buildings;
  final Map<String, String> specialFloorTitles;
  final int doorsPerFloor;
  final Set<String> bannedApartments; // could be { "C1207", "A0101" }

  Rules(
      {this.version = 0,
      this.personsPerTimeSlot = 4,
      this.habitantsPerApartment = 4,
      this.buildings = defaultBuilding,
      this.specialFloorTitles = defaultSpecialFloors,
      this.doorsPerFloor = 8,
      this.bannedApartments = defaultBannedApartments});
}

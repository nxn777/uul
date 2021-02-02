class Rules {
  final int personsPerTimeSlot = 4;
  final int usersPerApartment = 4;
  final Map<String, int> buildings = {"A": 10, "B": 10, "C": 12, "D": 12};
  final Map<String, String> specialFloorTitles = {"A10": "PH", "B10": "PH", "C12": "PH", "D12": "PH"};
  final int doorsPerFloor = 8;
  final Set<String> excludedDoors = {}; // could be { "C1207", "A0101" }
}

import 'package:core/core.dart';

import 'rules_api_client.dart';

extension Mapper on RulesDTO {
  Rules mapToDomain() {
    Map<String, int> buildings = new Map();
    this.towers.forEach((tower) {
      buildings[tower.name] = tower.floorCount;
    });
    Map<String, String> floorTitles = new Map();
    this.specialFloors.forEach((specialFloor) {
      floorTitles[specialFloor.name] = specialFloor.alias;
    });
    return Rules(
        version: this.version,
        personsPerTimeSlot: this.personsPerTimeSlot,
        habitantsPerApartment: this.habitantsPerApartment,
        doorsPerFloor: this.doorsPerFloor,
        buildings: buildings,
        specialFloorTitles: floorTitles,
        bannedApartments: this.bannedApartments.map((e) => e.name).toSet());
  }
}

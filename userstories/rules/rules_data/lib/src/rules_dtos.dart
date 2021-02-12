import 'package:core/core.dart';
import 'package:rest/rest.dart';

class RulesDTO implements HasFromJson, HasMapToDomain<Rules> {
  int _version;
  int _personsPerTimeSlot;
  int _habitantsPerApartment;
  int _doorsPerFloor;
  List<TowerDTO> _towers;
  List<SpecialFloorDTO> _specialFloors;
  List<BannedApartmentDTO> _bannedApartments;

  int get version => _version;
  int get personsPerTimeSlot => _personsPerTimeSlot;
  int get habitantsPerApartment => _habitantsPerApartment;
  int get doorsPerFloor => _doorsPerFloor;
  List<TowerDTO> get towers => _towers;
  List<SpecialFloorDTO> get specialFloors => _specialFloors;
  List<BannedApartmentDTO> get bannedApartments => _bannedApartments;

  RulesDTO();

  @override
  populateFromJson(json) {
    _version = json["version"];
    _personsPerTimeSlot = json["personsPerTimeSlot"];
    _habitantsPerApartment = json["habitantsPerApartment"];
    _doorsPerFloor = json["doorsPerFloor"];
    if (json["towers"] != null) {
      _towers = [];
      json["towers"].forEach((t) {
        _towers.add(TowerDTO.fromJson(t));
      });
    }
    if (json["specialFloors"] != null) {
      _specialFloors = [];
      json["specialFloors"].forEach((t) {
        _specialFloors.add(SpecialFloorDTO.fromJson(t));
      });
    }
    if (json["bannedApartments"] != null) {
      _bannedApartments = [];
      json["bannedApartments"].forEach((t) {
        _bannedApartments.add(BannedApartmentDTO.fromJson(t));
      });
    }
  }

  @override
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

class TowerDTO {
  String _name;
  int _floorCount;

  String get name => _name;
  int get floorCount => _floorCount;

  TowerDTO.fromJson(dynamic json) {
    _name = json["name"];
    _floorCount = json["floorCount"];
  }
}

class SpecialFloorDTO {
  String _name;
  String _alias;

  String get name => _name;
  String get alias => _alias;

  SpecialFloorDTO.fromJson(dynamic json) {
    _name = json["name"];
    _alias = json["alias"];
  }
}

class BannedApartmentDTO {
  String _name;

  String get name => _name;

  BannedApartmentDTO.fromJson(dynamic json) {
    _name = json["name"];
  }
}

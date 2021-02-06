import 'package:UUL_Gym/data/rest/rest_api.dart';
import 'package:UUL_Gym/data/rest/uul_response.dart';

class RulesApiClient {
  static Future<UULResponse<RulesDTO>> fetchRules() async {
    var response = await getDio().get("/api/Rules");
    return UULResponse(response, RulesDTO());
  }
}

class RulesDTO with HasFromJson {
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
    _habitantsPerApartment = json["usersPerApartment"];
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

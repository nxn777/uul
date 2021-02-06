import 'package:UUL_Gym/common/kv_store.dart';
import 'package:UUL_Gym/data/apiclient/rules_api_client.dart';
import 'file:///C:/local/flutter/UUL_Gym/rest/lib/src/uul_response.dart';
import 'package:UUL_Gym/models/result.dart';
import 'package:UUL_Gym/models/rules.dart';


const String _CACHED_RULES = "cached_rules";

class RulesRepo {
  final KVStore _store;

  RulesRepo(this._store);

  Future<UULResult<Rules>> loadRules({bool forced = false}) async {
    if (!forced) {
      var _cachedRawData = _store.getString(_CACHED_RULES, "");
      if (_cachedRawData.isNotEmpty) {
        var dto = RulesDTO();
        return UULResult.success(UULResponse.fromCachedData(_cachedRawData, dto).data.mapToDomain());
      }
    }
    var response = await RulesApiClient.fetchRules();
    await _store.setString(_CACHED_RULES, response.rawData);
    if (response.isSuccess) {
      return UULResult.success(response.data.mapToDomain());
    } else {
      return UULResult.failure(response);
    }
  }
}

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
      bannedApartments: this.bannedApartments.map((e) => e.name).toSet()
    );
  }
}
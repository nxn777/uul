import 'package:core/core.dart';
import 'package:rest/rest.dart';
import 'package:intl/intl.dart';
class InhabitantDTO implements HasMapToDomain<Inhabitant>{
  int _id;
  String _name;
  String _avatarSrc;
  String _apartmentCode;
  String _lastVisited;

  int get id => _id;
  String get name => _name;
  String get avatarSrc => _avatarSrc;
  String get apartmentCode => _apartmentCode;
  String get lastVisited => _lastVisited;

  InhabitantDTO.fromJson(dynamic json) {
    populateFromJson(json);
  }

  @override
  Inhabitant mapToDomain() {
    var lastGymVisitDT = lastVisited == null ? null : DateTime.tryParse(lastVisited);
    String lastGymVisit = lastGymVisitDT == null ? null : DateFormat('MM/dd/yyyy – kk:mm').format(lastGymVisitDT.toLocal());
    return Inhabitant(id: id, name: name, avatarSrc: avatarSrc, apartmentCode: apartmentCode, lastVisit: lastGymVisit);
  }

  @override
  populateFromJson(json) {
    _id = json["id"];
    _name = json["name"];
    _avatarSrc = json["avatarSrc"];
    _apartmentCode = json["apartmentCode"];
    _lastVisited = json["lastGymVisit"];
  }
}
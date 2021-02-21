import 'package:core/core.dart';
import 'package:rest/rest.dart';
class InhabitantDTO implements HasMapToDomain<Inhabitant>{
  int _id;
  String _name;
  String _avatarSrc;
  String _apartmentCode;

  int get id => _id;
  String get name => _name;
  String get avatarSrc => _avatarSrc;
  String get apartmentCode => _apartmentCode;

  InhabitantDTO.fromJson(dynamic json) {
    populateFromJson(json);
  }

  @override
  Inhabitant mapToDomain() {
    return Inhabitant(id: id, name: name, avatarSrc: avatarSrc, apartmentCode: apartmentCode);
  }

  @override
  populateFromJson(json) {
    _id = json["id"];
    _name = json["name"];
    _avatarSrc = json["avatarSrc"];
    _apartmentCode = json["apartmentCode"];
  }
}
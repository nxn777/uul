import 'package:core/core.dart';
import 'package:rest/rest.dart';
import 'package:caching/caching.dart';

class TokenDTO implements HasFromJson {
  String value;

  @override
  populateFromJson(jsonRaw) {
    value = jsonRaw.toString();
  }
}

class SingleValueDTO implements HasFromJson {
  String value;

  @override
  populateFromJson(jsonRaw) {
    value = jsonRaw.toString();
  }
}

class InhabitantDTO {
  int _id;
  String _name;
  String _avatarSrc;

  int get id => _id;
  String get name => _name;
  String get avatarSrc => _avatarSrc;

  InhabitantDTO.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _avatarSrc = json["avatarSrc"];
  }
}

class UserDTO implements HasFromJson, HasMapToDomain<User> {
  String _login;
  String _apartmentCode;
  bool _isActivated;
  List<InhabitantDTO> _inhabitants;

  String get login => _login;
  String get apartmentCode => _apartmentCode;
  bool get isActivated => _isActivated;
  List<InhabitantDTO> get inhabitants => _inhabitants;

  @override
  populateFromJson(json) {
    _login = json["login"];
    _apartmentCode = json["apartmentCode"];
    _isActivated = json["isActivated"];
    if (json["habitants"] != null) {
      _inhabitants = [];
      json["habitants"].forEach((h) => _inhabitants.add(InhabitantDTO.fromJson(h)));
    }
  }

  @override
  User mapToDomain() {
    return User(
      login: this.login,
      apartmentCode: this.apartmentCode,
      isActivated: this.isActivated,
      inhabitants: this.inhabitants.map((e) => Inhabitant(id: e.id, name: e.name, avatarSrc: e.avatarSrc)).toList(),
    );
  }
}

class NewUserDTO {
    String apartmentCode;
    String avatarSrc;
    String login;
    String name;
    String pwd;

    NewUserDTO({this.apartmentCode, this.avatarSrc, this.login, this.name, this.pwd});

    factory NewUserDTO.fromJson(Map<String, dynamic> json) {
        return NewUserDTO(
            apartmentCode: json['apartmentCode'],
            avatarSrc: json['avatarSrc'],
            login: json['login'],
            name: json['name'],
            pwd: json['pwd'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['apartmentCode'] = this.apartmentCode;
        data['avatarSrc'] = this.avatarSrc;
        data['login'] = this.login;
        data['name'] = this.name;
        data['pwd'] = this.pwd;
        return data;
    }
}

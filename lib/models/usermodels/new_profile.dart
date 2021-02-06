
class NewProfile {
  String _name;
  String _login;
  String _pwd;
  String _apartmentCode;
  String _avatarImageSrc;


  String get name => _name;
  String get login => _login;
  String get pwdHash => _pwd;
  String get avatarImageSrc => _avatarImageSrc;
  String get apartmentCode => _apartmentCode;

  NewProfile({String name, String loging, String pwd, String apartmentCode, String avatarImageSrc}) {
    _name = name;
    _login = login;
    _avatarImageSrc = avatarImageSrc;
    _pwd = pwd;
    _apartmentCode = apartmentCode;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["pwd"] = _pwd;
    map["apartmentCode"] = _apartmentCode;
    map["avatarSrc"] = _avatarImageSrc;
    map["login"] = _login;
    return map;
  }
}

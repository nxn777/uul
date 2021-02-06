// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewProfileDTO _$NewProfileDTOFromJson(Map<String, dynamic> json) {
  return NewProfileDTO(
    json['name'] as String,
    json['login'] as String,
    json['pwd'] as String,
    json['apartmentCode'] as String,
    json['avatarSrc'] as String,
  );
}

Map<String, dynamic> _$NewProfileDTOToJson(NewProfileDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'login': instance.login,
      'pwd': instance.pwd,
      'apartmentCode': instance.apartmentCode,
      'avatarSrc': instance.avatarImageSrc,
    };

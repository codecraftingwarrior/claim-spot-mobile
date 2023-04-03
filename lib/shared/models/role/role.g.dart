// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      json['id'] as int,
      code: json['code'] as String,
      nom: json['nom'] as String,
    )..permissions = json['permissions'] as List<dynamic>?;

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'nom': instance.nom,
      'permissions': instance.permissions,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie_vehicule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategorieVehicule _$CategorieVehiculeFromJson(Map<String, dynamic> json) =>
    CategorieVehicule(
      json['id'],
      code: json['code'] as String,
      libelle: json['libelle'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$CategorieVehiculeToJson(CategorieVehicule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'libelle': instance.libelle,
      'icon': instance.icon,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etat _$EtatFromJson(Map<String, dynamic> json) => Etat(
      code: json['code'] as String,
      libelle: json['libelle'] as String,
      etatSuivant: json['etatSuivant'] == null
          ? null
          : Etat.fromJson(json['etatSuivant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EtatToJson(Etat instance) => <String, dynamic>{
      'code': instance.code,
      'libelle': instance.libelle,
      'etatSuivant': instance.etatSuivant,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rendez_vous.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RendezVous _$RendezVousFromJson(Map<String, dynamic> json) => RendezVous(
      json['id'],
      description: json['description'] as String,
      creneau: Creneau.fromJson(json['creneau'] as Map<String, dynamic>),
      accident: Accident.fromJson(json['accident'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RendezVousToJson(RendezVous instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'creneau': instance.creneau,
      'accident': instance.accident,
    };

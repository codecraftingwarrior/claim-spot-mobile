// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accident _$AccidentFromJson(Map<String, dynamic> json) => Accident(
      id: json['id'] as int,
      code: json['code'] as String,
      heure: json['heure'] as String,
      date: DateTime.fromMicrosecondsSinceEpoch((json['date'] as int) * 1000),
      lieu: json['lieu'] as String,
      details: json['details'] as String,
      changed: json['changed'] as bool,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
          (json['createdAt'] as int) * 1000),
      montantRemboursement:
          (json['montantRemboursement'] as num?)?.toDouble() ?? 0.0,
      montantReparation: (json['montantReparation'] as num?)?.toDouble() ?? 0.0,
      applicationUser: ApplicationUser.fromJson(
          json['applicationUser'] as Map<String, dynamic>),
      vehicule: Vehicule.fromJson(json['vehicule'] as Map<String, dynamic>),
      etat: Etat.fromJson(json['etat'] as Map<String, dynamic>),
      detailAdversaire: (json['detailAdversaire'] is int) ? (json['detailAdversaire'] is int) : DetailAdversaire.fromJson(
          json['detailAdversaire'] as Map<String, dynamic>),
      rendezVous: json['rendezVous'],
      photos: json['photos'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$AccidentToJson(Accident instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'code': instance.code,
      'heure': instance.heure,
      'lieu': instance.lieu,
      'details': instance.details,
      'changed': instance.changed,
      'createdAt': instance.createdAt?.toIso8601String(),
      'montantRemboursement': instance.montantRemboursement,
      'montantReparation': instance.montantReparation,
      'applicationUser': instance.applicationUser,
      'vehicule': instance.vehicule,
      'etat': instance.etat,
      'detailAdversaire': instance.detailAdversaire,
      'rendezVous': instance.rendezVous,
      'photos': instance.photos,
    };


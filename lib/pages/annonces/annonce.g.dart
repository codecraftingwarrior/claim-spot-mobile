// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Annonce _$AnnonceFromJson(Map<String, dynamic> json) => Annonce(
      json['id'],
      libelle: json['libelle'] as String,
      prix: (json['prix'] as num).toDouble(),
      type: json['type'] as String,
      validated: json['validated'] as bool,
      disabled: json['disabled'] as bool,
      vehicule: json['vehicule'] != null ? Vehicule.fromJson(json['vehicule'] as Map<String, dynamic>) : null,
      createdAt: json['createdAt'] is String ? DateTime.parse(json['createdAt']) : DateTime.fromMicrosecondsSinceEpoch((json['createdAt'] as int) * 1000),
    );

Map<String, dynamic> _$AnnonceToJson(Annonce instance) => <String, dynamic>{
      'id': instance.id,
      'libelle': instance.libelle,
      'prix': instance.prix,
      'type': instance.type,
      'validated': instance.validated,
      'disabled': instance.disabled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'vehicule': instance.vehicule,
    };

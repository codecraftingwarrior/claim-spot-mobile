// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Formule _$FormuleFromJson(Map<String, dynamic> json) => Formule(
      json['id'] as int,
      code: json['code'] as String,
      libelle: json['libelle'] as String,
      montant: json['montant'] as double,
      canPost: json['canPost'] as bool,
      visible: json['visible'] as bool,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$FormuleToJson(Formule instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'libelle': instance.libelle,
      'montant': instance.montant,
      'canPost': instance.canPost,
      'visible': instance.visible,
      'description': instance.description,
      'options': instance.options,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creneau.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Creneau _$CreneauFromJson(Map<String, dynamic> json) => Creneau(
      json['id'],
      date: DateTime.fromMicrosecondsSinceEpoch((json['date'] as int) * 1000),
      heure: json['heure'] as String,
      choosen: json['choosen'] as bool,
    );

Map<String, dynamic> _$CreneauToJson(Creneau instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'heure': instance.heure,
      'choosen': instance.choosen,
    };

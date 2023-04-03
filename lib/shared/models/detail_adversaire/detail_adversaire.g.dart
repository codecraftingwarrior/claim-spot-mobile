// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_adversaire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailAdversaire _$DetailAdversaireFromJson(Map<String, dynamic> json) =>
    DetailAdversaire(
      json['id'],
      prenom: json['prenom'] as String?,
      nom: json['nom'] as String?,
      genre: json['genre'] as String,
      marqueVehicule: json['marqueVehicule'] as String,
      modeleVehicule: json['modeleVehicule'] as String,
      immatriculation: json['immatriculation'] as String?,
      description: json['description'] as String,
      categorieVehicule: CategorieVehicule.fromJson(
          json['categorieVehicule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailAdversaireToJson(DetailAdversaire instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prenom': instance.prenom,
      'nom': instance.nom,
      'genre': instance.genre,
      'marqueVehicule': instance.marqueVehicule,
      'modeleVehicule': instance.modeleVehicule,
      'immatriculation': instance.immatriculation,
      'description': instance.description,
      'categorieVehicule': instance.categorieVehicule,
    };

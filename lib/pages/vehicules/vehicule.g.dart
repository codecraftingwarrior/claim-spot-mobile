// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicule _$VehiculeFromJson(Map<String, dynamic> json) => Vehicule(
      json['id'],
      immatriculation: json['immatriculation'] as String,
      marque: json['marque'] as String,
      modele: json['modele'] as String,
      imgFilename: json['imgFilename'] as String?,
      imgUrl: json['imgUrl'] as String?,
      image: json['image'] as String?,
      categorie:
          CategorieVehicule.fromJson(json['categorie'] as Map<String, dynamic>),
      annonce: json['annonce'] != null ? (json['annonce'] is int ? null : Annonce.fromJson(json['annonce'] as Map<String, dynamic>)) : null,
      applicationUser: ApplicationUser.fromJson(
          json['applicationUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VehiculeToJson(Vehicule instance) => <String, dynamic>{
      'id': instance.id,
      'immatriculation': instance.immatriculation,
      'marque': instance.marque,
      'modele': instance.modele,
      'imgFilename': instance.imgFilename,
      'imgUrl': instance.imgUrl,
      'image': instance.image,
      'categorie': instance.categorie,
      'annonce': instance.annonce,
      'applicationUser': instance.applicationUser,
    };

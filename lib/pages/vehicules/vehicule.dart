import 'package:flutter/material.dart';
import 'package:insurance_mobile_app/pages/annonces/annonce.dart';
import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule.dart';
import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicule.g.dart';

@JsonSerializable(createToJson: true)
class Vehicule extends BaseModel {
  String? immatriculation, marque, modele;
  String? imgFilename, imgUrl, image;
  CategorieVehicule? categorie;
  ApplicationUser? applicationUser;
  Annonce? annonce;

  Vehicule(id,
      { this.immatriculation,
        this.marque,
        this.modele,
        this.imgFilename,
        this.imgUrl,
        this.image,
        this.categorie,
        this.annonce,
        this.applicationUser})
      : super(id: id);

  factory Vehicule.fromJson(Map<String, dynamic> json) =>
      _$VehiculeFromJson(json);

  Map<String, dynamic> toJson() => _$VehiculeToJson(this);

  @override
  Vehicule fromJson(Map<String, dynamic> json) {
    return Vehicule.fromJson(json);
  }
  static Vehicule getInstance() {
    return Vehicule(null);
  }
}

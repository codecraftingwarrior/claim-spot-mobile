import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule.dart';
import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_adversaire.g.dart';

@JsonSerializable(createToJson: true)
class DetailAdversaire extends BaseModel {
  String? genre, marqueVehicule, modeleVehicule, description;
  String? prenom, nom, immatriculation;
  CategorieVehicule? categorieVehicule;

  DetailAdversaire(id,
      {this.prenom,
      this.nom,
      this.genre,
      this.marqueVehicule,
      this.modeleVehicule,
      this.immatriculation,
      this.description,
      this.categorieVehicule})
      : super(id: id);

  factory DetailAdversaire.fromJson(Map<String, dynamic> json) =>
      _$DetailAdversaireFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAdversaireToJson(this);

  @override
  DetailAdversaire fromJson(Map<String, dynamic> json) {
    return DetailAdversaire.fromJson(json);
  }

  static DetailAdversaire getInstance() {
    return DetailAdversaire(null);
  }
}

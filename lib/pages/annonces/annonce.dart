import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'annonce.g.dart';

@JsonSerializable(createToJson: true)
class Annonce extends BaseModel {
  String? libelle;
  double? prix;
  String? type;
  bool? validated, disabled;
  DateTime? createdAt;
  Vehicule? vehicule;

  Annonce(id,
      {this.libelle,
      this.prix,
      this.type,
      this.validated,
      this.disabled,
      this.vehicule,
      this.createdAt})
      : super(id: id);

  factory Annonce.fromJson(Map<String, dynamic> json) =>
      _$AnnonceFromJson(json);

  Map<String, dynamic> toJson() => _$AnnonceToJson(this);

  @override
  Annonce fromJson(Map<String, dynamic> json) {
    return Annonce.fromJson(json);
  }

  static Annonce getInstance() {
   return Annonce(null);
  }
}

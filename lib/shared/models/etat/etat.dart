import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'etat.g.dart';

@JsonSerializable(createToJson: true)
class Etat extends BaseModel {
  String? code;
  String? libelle;
  Etat? etatSuivant;

  Etat({required this.code, required this.libelle, this.etatSuivant});

  factory Etat.fromJson(Map<String, dynamic> json) => _$EtatFromJson(json);
  Map<String, dynamic> toJson() => _$EtatToJson(this);

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return Etat.fromJson(json);
  }

}
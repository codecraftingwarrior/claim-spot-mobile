import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'categorie_vehicule.g.dart';

@JsonSerializable(createToJson: true)
class CategorieVehicule extends BaseModel {
  String? code, libelle, icon;

  CategorieVehicule(id,
      {this.code, this.libelle, this.icon})
      : super(id: id);

  factory CategorieVehicule.fromJson(Map<String, dynamic> json) => _$CategorieVehiculeFromJson(json);
  Map<String, dynamic> toJson() => _$CategorieVehiculeToJson(this);

  @override
  CategorieVehicule fromJson(Map<String, dynamic> json) {
    return CategorieVehicule.fromJson(json);
  }

  @override
  BaseModel getInstance() {
   return CategorieVehicule(null);
  }

}

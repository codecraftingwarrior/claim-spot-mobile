import 'package:insurance_mobile_app/pages/accident/accident.dart';
import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:insurance_mobile_app/shared/models/creneau/creneau.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rendez_vous.g.dart';

@JsonSerializable(createToJson: true)
class RendezVous extends BaseModel {
  String? description;
  Creneau? creneau;
  Accident? accident;

  RendezVous(id, {required this.description, required this.creneau, required this.accident}): super(id: id);

  factory RendezVous.fromJson(Map<String, dynamic> json) => _$RendezVousFromJson(json);
  Map<String, dynamic> toJson() => _$RendezVousToJson(this);

  @override
  RendezVous fromJson(Map<String, dynamic> json) {
    return RendezVous.fromJson(json);
  }
}
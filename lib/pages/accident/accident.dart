import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:insurance_mobile_app/shared/models/detail_adversaire/detail_adversaire.dart';
import 'package:insurance_mobile_app/shared/models/etat/etat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accident.g.dart';

@JsonSerializable(createToJson: true)
class Accident extends BaseModel {
  String? code;
  DateTime? date;
  String? heure;
  String? lieu;
  String? details;
  bool? changed;
  DateTime? createdAt;
  double? montantRemboursement;
  double? montantReparation;
  dynamic applicationUser;
  Vehicule? vehicule;
  Etat? etat;
  dynamic detailAdversaire;
  dynamic rendezVous;
  List<dynamic>? photos;
  Accident({
    id,
    this.code,
    this.date,
    this.heure,
    this.lieu,
    this.details,
    this.changed,
    this.createdAt,
    this.montantRemboursement = 0.0,
    this.montantReparation = 0.0,
    this.applicationUser,
    this.vehicule,
    this.etat,
    this.detailAdversaire,
    this.rendezVous,
    this.photos = const []
  }): super(id: id);

  @override
  factory Accident.fromJson(Map<String, dynamic> json)  => _$AccidentFromJson(json);
  Map<String, dynamic> toJson() => _$AccidentToJson(this);

  @override
  Accident fromJson(Map<String, dynamic> json) {
    return Accident.fromJson(json);
  }

  static Accident getInstance() {
    return Accident();
  }

  
}
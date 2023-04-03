import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'creneau.g.dart';

@JsonSerializable(createToJson: true)
class Creneau extends BaseModel {
  DateTime? date;
  String? heure;
  bool? choosen;

  Creneau(id, {this.date, this.heure, this.choosen}) : super(id: id);

  factory Creneau.fromJson(Map<String, dynamic> json) =>
      _$CreneauFromJson(json);

  Map<String, dynamic> toJson() => _$CreneauToJson(this);

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return Creneau.fromJson(json);
  }
}

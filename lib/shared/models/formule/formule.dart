import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'option.dart';

part 'formule.g.dart';

@JsonSerializable(createToJson: true)
class Formule extends BaseModel {
  String? code, libelle;
  double? montant;
  bool? canPost, visible;
  String? description;
  List<Option>? options;

  Formule(int id,
      {this.code,
      this.libelle,
      this.montant,
      this.canPost,
      this.visible,
      this.options,
      this.description})
      : super(id: id);

  factory Formule.fromJson(Map<String, dynamic> json) =>
      _$FormuleFromJson(json);

  Map<String, dynamic> toJson() => _$FormuleToJson(this);

  @override
  Formule fromJson(Map<String, dynamic> json) {
    return Formule.fromJson(json);
  }
}

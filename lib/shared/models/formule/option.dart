import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'option.g.dart';

@JsonSerializable(createToJson: true)
class Option extends BaseModel {
  String? libelle;
  Option(id, {this.libelle}): super(id: id);

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);

  @override
  Option fromJson(Map<String, dynamic> json) {
    return Option.fromJson(json);
  }
}
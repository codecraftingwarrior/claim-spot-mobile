import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'role.g.dart';

@JsonSerializable(createToJson: true)
class Role extends BaseModel {
  String? code, nom;
  List<dynamic>? permissions;

  Role(int id, {required this.code, required this.nom}): super(id: id);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
  return Role.fromJson(json);
  }
}
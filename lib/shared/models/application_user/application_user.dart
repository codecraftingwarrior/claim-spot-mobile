import 'package:insurance_mobile_app/shared/common/base_model.dart';
import 'package:insurance_mobile_app/shared/models/role/role.dart';
import 'package:json_annotation/json_annotation.dart';
import '../formule/formule.dart';

part 'application_user.g.dart';

@JsonSerializable(createToJson: true)
class ApplicationUser extends BaseModel {
  String? username;
  String? password;
  String? plainPassword;
  String? newPassword;
  List<dynamic>? authorities;
  String? imageFilename, imageFilepath, imgProfile;
  String? prenom, nom, telephone, adresse, fonction, genre;
  bool? accountNonExpired, accountNonLocked, credentialsNonExpired, enabled;
  List<dynamic>? grantedAuthorities;
  List<Role>? roles;
  Formule? formule;

  ApplicationUser(int id,
      {this.username,
      this.password,
      this.plainPassword,
      this.newPassword,
      this.authorities,
      this.prenom,
      this.nom,
      this.telephone,
      this.adresse,
      this.fonction,
      this.genre,
      this.imageFilename,
      this.imageFilepath,
      this.imgProfile,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired,
      this.enabled,
      this.grantedAuthorities,
      this.roles,
      this.formule})
      : super(id: id);

  factory ApplicationUser.fromJson(Map<String, dynamic> json) =>
      _$ApplicationUserFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationUserToJson(this);

  @override
  ApplicationUser fromJson(Map<String, dynamic> json) {
   return ApplicationUser.fromJson(json);
  }
}

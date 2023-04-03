// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationUser _$ApplicationUserFromJson(Map<String, dynamic> json) =>
    ApplicationUser(
      json['id'] as int,
      username: json['username'] as String?,
      password: json['password'] as String?,
      plainPassword: json['plainPassword'] as String?,
      newPassword: json['newPassword'] as String?,
      authorities: json['authorities'] as List<dynamic>?,
      prenom: json['prenom'] as String?,
      nom: json['nom'] as String?,
      telephone: json['telephone'] as String?,
      adresse: json['adresse'] as String?,
      fonction: json['fonction'] as String?,
      genre: json['genre'] as String?,
      imageFilename: json['imageFilename'] as String?,
      imageFilepath: json['imageFilepath'] as String?,
      imgProfile: json['imgProfile'] as String?,
      accountNonExpired: json['accountNonExpired'] as bool?,
      accountNonLocked: json['accountNonLocked'] as bool?,
      credentialsNonExpired: json['credentialsNonExpired'] as bool?,
      enabled: json['enabled'] as bool?,
      grantedAuthorities: json['grantedAuthorities'] as List<dynamic>?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      formule: json['formule'] != null ? Formule.fromJson(json['formule'] as Map<String, dynamic>) : null,
    );

Map<String, dynamic> _$ApplicationUserToJson(ApplicationUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'plainPassword': instance.plainPassword,
      'newPassword': instance.newPassword,
      'authorities': instance.authorities,
      'prenom': instance.prenom,
      'nom': instance.nom,
      'telephone': instance.telephone,
      'adresse': instance.adresse,
      'fonction': instance.fonction,
      'genre': instance.genre,
      'imageFilename': instance.imageFilename,
      'imageFilepath': instance.imageFilepath,
      'imgProfile': instance.imgProfile,
      'accountNonExpired': instance.accountNonExpired,
      'accountNonLocked': instance.accountNonLocked,
      'credentialsNonExpired': instance.credentialsNonExpired,
      'enabled': instance.enabled,
      'grantedAuthorities': instance.grantedAuthorities,
      'roles': instance.roles,
      'formule': instance.formule,
    };

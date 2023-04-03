import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

@JsonSerializable(createToJson: true)
class Credentials {
  final String username;
  final String password;

  Credentials({required this.username, required this.password});

  factory Credentials.fromJson(Map<String, dynamic> json) => _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  String? token;
  User? user;

  LoginResponse({this.message, this.token, this.user});
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? role;
  List<String>? permissions;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.permissions,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

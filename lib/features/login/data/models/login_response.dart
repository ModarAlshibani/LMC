import 'package:json_annotation/json_annotation.dart';

class LoginResponse {
  final String token;

  LoginResponse({required this.token});
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(token: json['token']);
}

class User {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? role;
  List<String>? permissions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.role,
    required this.permissions,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

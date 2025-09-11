class LoginResponse {
  String? message;
  String? token;
  User? user;

  LoginResponse({this.message, this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    token = json['token'] as String?;
    user = json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    if (user != null) map['user'] = user!.toJson();
    return map;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt; // keep as String?
  String? role;
  List<String>? permissions;
  OtherInfo? otherInfo;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.permissions,
    this.otherInfo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?, // API returns ISO string or null
      role: json['role'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      // Note: key has a space: "Other Info"
      otherInfo: json['Other Info'] != null
          ? OtherInfo.fromJson(json['Other Info'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['role'] = role;
    if (permissions != null) map['permissions'] = permissions;
    if (otherInfo != null) map['Other Info'] = otherInfo!.toJson();
    return map;
  }
}

class OtherInfo {
  String? photo;       // maps "Photo"
  String? description; // maps "Description"

  OtherInfo({this.photo, this.description});

  factory OtherInfo.fromJson(Map<String, dynamic> json) {
    return OtherInfo(
      photo: json['Photo'] as String?,
      description: json['Description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Photo': photo,
      'Description': description,
    };
  }
}
class LoginResponse {
  String? message;
  String? token;
  User? user;

  LoginResponse({this.message, this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    permissions =
        json['permissions'] != null
            ? List<String>.from(json['permissions'])
            : [];
    otherInfo =
        json['Other Info'] != null
            ? new OtherInfo.fromJson(json['Other Info'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['permissions'] = this.permissions;
    if (this.otherInfo != null) {
      data['Other Info'] = this.otherInfo!.toJson();
    }
    return data;
  }
}

class OtherInfo {
  Null? photo;
  Null? description;

  OtherInfo({this.photo, this.description});

  OtherInfo.fromJson(Map<String, dynamic> json) {
    photo = json['Photo'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Photo'] = this.photo;
    data['Description'] = this.description;
    return data;
  }
}

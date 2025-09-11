class PrivateCourseModel {
  List<Request>? requests;

  PrivateCourseModel({this.requests});

  PrivateCourseModel.fromJson(List<dynamic> json) {
    requests = <Request>[];
    for (var v in json) {
      requests!.add(Request.fromJson(v));
    }
  }

  List<Map<String, dynamic>> toJson() {
    if (requests != null) {
      return requests!.map((v) => v.toJson()).toList();
    }
    return [];
  }
}

class Request {
  int? id;
  int? userId;
  String? languageId;
  String? description;
  String? secResponse;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Language? language;

  Request({
    this.id,
    this.userId,
    this.languageId,
    this.description,
    this.secResponse,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.language,
  });

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    languageId = json['language_id'].toString();
    description = json['description'];
    secResponse = json['secretarya_response'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    language = json['language'] != null ? Language.fromJson(json['language']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['language_id'] = languageId;
    data['description'] = description;
    data['secretarya_response'] = secResponse;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) data['user'] = user!.toJson();
    if (language != null) data['language'] = language!.toJson();
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['role_id'] = roleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Language {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Language({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['Description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

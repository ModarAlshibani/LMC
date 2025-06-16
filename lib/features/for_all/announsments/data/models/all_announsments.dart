class AllAnnounsmentsModel {
  List<Announcements>? announcements;

  AllAnnounsmentsModel({this.announcements});

  AllAnnounsmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['announcements'] != null) {
      announcements = <Announcements>[];
      json['announcements'].forEach((v) {
        announcements!.add(new Announcements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.announcements != null) {
      data['announcements'] =
          this.announcements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Announcements {
  int? id;
  int? creatorId;
  String? title;
  String? content;
  String? media;
  String? createdAt;
  String? updatedAt;
  Creator? creator;

  Announcements({
    this.id,
    this.creatorId,
    this.title,
    this.content,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.creator,
  });

  Announcements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['CreatorId'];
    title = json['Title'];
    content = json['Content'];
    photo = json['Photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CreatorId'] = this.creatorId;
    data['Title'] = this.title;
    data['Content'] = this.content;
    data['Photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    return data;
  }
}

class Creator {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  Creator({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

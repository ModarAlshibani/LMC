class LmcInfoModel {
  String? title;
  List<InfoDescription>? description;
  String? photo;
  List<Teacher>? teachers;
  List<Language>? languages;

  LmcInfoModel({
    this.title,
    this.description,
    this.photo,
    this.teachers,
    this.languages,});
  
 

  LmcInfoModel.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    if(json['Description'] != null){
      description = <InfoDescription>[];
      json['Description'].forEach((v){
        description!.add(new InfoDescription.fromJson(v));
      });
    }
    photo = json['Photo'];
    if(json['Teachers'] != null){
      teachers = <Teacher>[];
      json['Teachers'].forEach((v){
        teachers!.add(new Teacher.fromJson(v));
      });
    }
    if(json['Languages'] != null){
      languages = <Language>[];
      json['Languages'].forEach((v){
        languages!.add(new Language.fromJson(v));
      });
    }
}

Map<String, dynamic> toJson(){
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Title'] = this.title;
  if(this.description != null){
    data['Description'] = this.description!.map((v) => v.toJson()).toList();
  }
  data['Photo'] = this.photo;
  if(this.teachers != null){
    data['Teachers'] = this.teachers!.map((v) => v.toJson()).toList();
  }
  if(this.languages != null){
    data['Languages'] = this.languages!.map((v) => v.toJson()).toList();
  }
  return data;
}

}

class InfoDescription {
  String? title;
  String? explanation;

  InfoDescription({
    this.title,
    this.explanation,
  });

  InfoDescription.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    explanation = json['Explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Explanation'] = this.explanation;
    return data;
  }
  
}

class Teacher {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Teacher({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Teacher.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
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
      name = json['Name'] ?? '';
      description = json['Description'] ?? '';
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

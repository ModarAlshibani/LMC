class TacherCourseLessonsModel {
  String? courseId;
  List<Lessons>? lessons;

  TacherCourseLessonsModel({this.courseId, this.lessons});

  TacherCourseLessonsModel.fromJson(Map<String, dynamic> json) {
    courseId = json['CourseId'];
    if (json['Lessons'] != null) {
      lessons = <Lessons>[];
      json['Lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CourseId'] = this.courseId;
    if (this.lessons != null) {
      data['Lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lessons {
  int? id;
  int? courseId;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  Course? course;

  Lessons(
      {this.id,
      this.courseId,
      this.title,
      this.date,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt,
      this.course});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['CourseId'];
    title = json['Title'];
    date = json['Date'];
    startTime = json['Start_Time'];
    endTime = json['End_Time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CourseId'] = this.courseId;
    data['Title'] = this.title;
    data['Date'] = this.date;
    data['Start_Time'] = this.startTime;
    data['End_Time'] = this.endTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  int? teacherId;
  int? languageId;
  String? description;
  String? photo;
  String? status;
  String? level;
  String? createdAt;
  String? updatedAt;
  Language? language;
  User? user;

  Course(
      {this.id,
      this.teacherId,
      this.languageId,
      this.description,
      this.photo,
      this.status,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.language,
      this.user});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['TeacherId'];
    languageId = json['LanguageId'];
    description = json['Description'];
    photo = json['Photo'];
    status = json['Status'];
    level = json['Level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TeacherId'] = this.teacherId;
    data['LanguageId'] = this.languageId;
    data['Description'] = this.description;
    data['Photo'] = this.photo;
    data['Status'] = this.status;
    data['Level'] = this.level;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Language {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Language(
      {this.id, this.name, this.description, this.createdAt, this.updatedAt});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
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

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

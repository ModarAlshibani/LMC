class StuGetFinalTestModel {
  String? message;
  FinalTest? finalTest;

  StuGetFinalTestModel({this.message, this.finalTest});

  StuGetFinalTestModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    finalTest = json['Final Test'] != null
        ? new FinalTest.fromJson(json['Final Test'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.finalTest != null) {
      data['Final Test'] = this.finalTest!.toJson();
    }
    return data;
  }
}

class FinalTest {
  int? id;
  int? courseId;
  String? title;
  int? duration;
  int? mark;
  User? user;

  FinalTest(
      {this.id,
      this.courseId,
      this.title,
      this.duration,
      this.mark,
      this.user});

  FinalTest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['CourseId'];
    title = json['Title'];
    duration = json['Duration'];
    mark = json['Mark'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CourseId'] = this.courseId;
    data['Title'] = this.title;
    data['Duration'] = this.duration;
    data['Mark'] = this.mark;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

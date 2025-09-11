class FinalTestModel {
  FinalTest? finalTest;

  FinalTestModel({this.finalTest});

  FinalTestModel.fromJson(Map<String, dynamic> json) {
    finalTest = json['Final Test'] != null
        ? new FinalTest.fromJson(json['Final Test'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.finalTest != null) {
      data['Final Test'] = this.finalTest!.toJson();
    }
    return data;
  }
}

class FinalTest {
  int? id;
  int? courseId;
  int? teacherId;
  String? title;
  int? duration;
  int? mark;
  String? createdAt;
  String? updatedAt;

  FinalTest(
      {this.id,
      this.courseId,
      this.teacherId,
      this.title,
      this.duration,
      this.mark,
      this.createdAt,
      this.updatedAt});

  FinalTest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['CourseId'];
    teacherId = json['TeacherId'];
    title = json['Title'];
    duration = json['Duration'];
    mark = json['Mark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CourseId'] = this.courseId;
    data['TeacherId'] = this.teacherId;
    data['Title'] = this.title;
    data['Duration'] = this.duration;
    data['Mark'] = this.mark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

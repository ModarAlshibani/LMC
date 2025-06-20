import '../../../show_my_courses/data/models/stu_my_courses_model.dart';

class LessonsModel {
  String? message;
  List<Lesson>? myLessons;

  LessonsModel({this.message, this.myLessons});

  LessonsModel.fromJson(Map<String, dynamic> json) {
    
    message = json['message'];
    if (json['My Lessons'] != null) {
      myLessons = <Lesson>[];
      for (var v in json['My Lessons']) {
        myLessons!.add(Lesson.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (myLessons != null) {
      data['My Lessons'] = myLessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lesson {
  int? id;
  int? courseId;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  MyCoursesStu? course;     

  Lesson({
    this.id,
    this.courseId,
    this.title,
    this.date,
    this.startTime,
    this.endTime,
    this.course,
  });

  Lesson.fromJson(Map<String, dynamic> json) {
  print('… parsing lesson json: $json');
    id        = json['id'] as int?;
    courseId  = json['CourseId'] as int?;
    title     = json['Title'];
    date      = json['Date'];
    startTime = json['Start_Time'];
    endTime   = json['End_Time'];
    course    = json['course'] != null
        ? MyCoursesStu.fromJson(json['course'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id']          = id;
    data['CourseId']    = courseId;
    data['Title']       = title;
    data['Date']        = date;
    data['Start_Time']  = startTime;
    data['End_Time']    = endTime;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

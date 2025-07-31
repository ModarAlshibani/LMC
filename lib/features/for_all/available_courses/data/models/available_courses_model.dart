class AvailableCoursesModel {
  String? message;
  List<AvailableCourses>? availableCourses;

  AvailableCoursesModel({this.message, this.availableCourses});

  AvailableCoursesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Available Courses'] != null) {
      availableCourses = <AvailableCourses>[];
      (json['Available Courses'] as List).forEach((v) {
        availableCourses!.add(AvailableCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (availableCourses != null) {
      data['Available Courses'] =
          availableCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class AvailableCourses {
  int? id;
  String? teacherName;
  String? languageName;
  String? description;
  String? photo;
  String? status;
  String? level;
  CourseSchedule? courseSchedule;

  AvailableCourses({
    this.id,
    this.teacherName,
    this.languageName,
    this.description,
    this.photo,
    this.status,
    this.level,
    this.courseSchedule,
  });

  AvailableCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherName = json['TeacherName'];
    languageName = json['LanguageName'];
    description = json['Description'];
    photo = json['Photo'];
    status = json['Status'];
    level = json['Level'];
    courseSchedule = json['course_schedule'] != null
        ? CourseSchedule.fromJson(json['course_schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['TeacherName'] = teacherName;
    data['LanguageName'] = languageName;
    data['Description'] = description;
    data['Photo'] = photo;
    data['Status'] = status;
    data['Level'] = level;
    if (courseSchedule != null) {
      data['course_schedule'] = courseSchedule!.toJson();
    }
    return data;
  }
}

class CourseSchedule {
  int? id;
  String? startDate;
  String? endDate;
  List<String>? days;
  String? startTime;
  String? endTime;
  dynamic numberOfRoom;

  CourseSchedule({
    this.id,
    this.startDate,
    this.endDate,
    this.days,
    this.startTime,
    this.endTime,
    this.numberOfRoom,
  });

  CourseSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['Start_Date'];
    endDate = json['End_Date'];
    days = json['Days'] != null ? List<String>.from(json['Days']) : null;
    startTime = json['Start_Time'];
    endTime = json['End_Time'];
    numberOfRoom = json['NumberOfRoom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['Start_Date'] = startDate;
    data['End_Date'] = endDate;
    data['Days'] = days;
    data['Start_Time'] = startTime;
    data['End_Time'] = endTime;
    data['NumberOfRoom'] = numberOfRoom;
    return data;
  }
}

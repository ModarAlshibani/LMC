class MyCoursesTeacherModel {
  List<MyCourses>? myCourses;

  MyCoursesTeacherModel({this.myCourses});

  MyCoursesTeacherModel.fromJson(Map<String, dynamic> json) {
    if (json['My Courses'] != null) {
      myCourses = <MyCourses>[];
      json['My Courses'].forEach((v) {
        myCourses!.add(new MyCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myCourses != null) {
      data['My Courses'] = this.myCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCourses {
  int? id;
  String? teacherName;
  String? languageName;
  String? description;
  String? level;
  String? status;
  String? photo;
  CourseSchedule? courseSchedule;

  MyCourses({
    this.id,
    this.teacherName,
    this.languageName,
    this.description,
    this.level,
    this.status,
    this.photo,
    this.courseSchedule,
  });

  MyCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherName = json['TeacherName'];
    languageName = json['LanguageName'];
    description = json['Description'];
    level = json['Level'];
    status = json['Status'];
    photo = json['Photo'];
    courseSchedule =
        json['course_schedule'] != null
            ? new CourseSchedule.fromJson(json['course_schedule'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TeacherName'] = this.teacherName;
    data['LanguageName'] = this.languageName;
    data['Description'] = this.description;
    data['Level'] = this.level;
    data['Status'] = this.status;
    data['Photo'] = this.photo;
    if (this.courseSchedule != null) {
      data['course_schedule'] = this.courseSchedule!.toJson();
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
  String? numberOfRoom;

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
    days = json['Days'].cast<String>();
    startTime = json['Start_Time'];
    endTime = json['End_Time'];
    numberOfRoom = json['NumberOfRoom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Start_Date'] = this.startDate;
    data['End_Date'] = this.endDate;
    data['Days'] = this.days;
    data['Start_Time'] = this.startTime;
    data['End_Time'] = this.endTime;
    data['NumberOfRoom'] = this.numberOfRoom;
    return data;
  }
}

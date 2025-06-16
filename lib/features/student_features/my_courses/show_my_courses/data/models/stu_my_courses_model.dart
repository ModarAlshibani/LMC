class MyCoursesModelStu {
  String? message;
  List<MyCoursesStu>? myCoursesStu;

  MyCoursesModelStu({this.message, this.myCoursesStu});

  MyCoursesModelStu.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Courses'] != null) {
      myCoursesStu = <MyCoursesStu>[];
      json['Courses'].forEach((v) {
        myCoursesStu!.add(new MyCoursesStu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.myCoursesStu != null) {
      data['Courses'] =
          this.myCoursesStu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCoursesStu {
  int? id;
  String? teacherName;
  int? languageId;
  String? description;
  String? photo;
  String? status;
  String? level;
  List<CourseSchedule>? courseSchedule;

  MyCoursesStu(
      {this.id,
      this.teacherName,
      this.languageId,
      this.description,
      this.photo,
      this.status,
      this.level,
      this.courseSchedule});

  MyCoursesStu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherName = json['TeacherName'];
    languageId = json['LanguageId'];
    description = json['Description'];
    photo = json['Photo'];
    status = json['Status'];
    level = json['Level'];
    if (json['course_schedule'] != null) {
      courseSchedule = <CourseSchedule>[];
      json['course_schedule'].forEach((v) {
        courseSchedule!.add(new CourseSchedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TeacherName'] = this.teacherName;
    data['LanguageId'] = this.languageId;
    data['Description'] = this.description;
    data['Photo'] = this.photo;
    data['Status'] = this.status;
    data['Level'] = this.level;
    if (this.courseSchedule != null) {
      data['course_schedule'] =
          this.courseSchedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseSchedule {
  int? id;
  int? courseId;
  int? roomId;
  String? startEnroll;
  String? endEnroll;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  List<String>? courseDays;
  String? createdAt;
  String? updatedAt;

  CourseSchedule(
      {this.id,
      this.courseId,
      this.roomId,
      this.startEnroll,
      this.endEnroll,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.courseDays,
      this.createdAt,
      this.updatedAt});

  CourseSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['CourseId'];
    roomId = json['RoomId'];
    startEnroll = json['Start_Enroll'];
    endEnroll = json['End_Enroll'];
    startDate = json['Start_Date'];
    endDate = json['End_Date'];
    startTime = json['Start_Time'];
    endTime = json['End_Time'];
    courseDays = json['CourseDays'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CourseId'] = this.courseId;
    data['RoomId'] = this.roomId;
    data['Start_Enroll'] = this.startEnroll;
    data['End_Enroll'] = this.endEnroll;
    data['Start_Date'] = this.startDate;
    data['End_Date'] = this.endDate;
    data['Start_Time'] = this.startTime;
    data['End_Time'] = this.endTime;
    data['CourseDays'] = this.courseDays;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

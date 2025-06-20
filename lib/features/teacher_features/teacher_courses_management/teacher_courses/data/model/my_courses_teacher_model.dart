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
  int? teacherId;
  int? languageId;
  String? description;
  String? photo;
  String? status;
  String? level;
  String? createdAt;
  String? updatedAt;
  List<CourseSchedule>? courseSchedule;

  MyCourses({
    this.id,
    this.teacherId,
    this.languageId,
    this.description,
    this.photo,
    this.status,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.courseSchedule,
  });

  MyCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['TeacherId'];
    languageId = json['LanguageId'];
    description = json['Description'];
    photo = json['Photo'];
    status = json['Status'];
    level = json['Level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['TeacherId'] = this.teacherId;
    data['LanguageId'] = this.languageId;
    data['Description'] = this.description;
    data['Photo'] = this.photo;
    data['Status'] = this.status;
    data['Level'] = this.level;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  String? enrollStatus;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  List<String>? courseDays;
  String? createdAt;
  String? updatedAt;

  CourseSchedule({
    this.id,
    this.courseId,
    this.roomId,
    this.startEnroll,
    this.endEnroll,
    this.enrollStatus,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.courseDays,
    this.createdAt,
    this.updatedAt,
  });

  CourseSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['CourseId'];
    roomId = json['RoomId'];
    startEnroll = json['Start_Enroll'];
    endEnroll = json['End_Enroll'];
    enrollStatus = json['Enroll_Status'];
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
    data['Enroll_Status'] = this.enrollStatus;
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

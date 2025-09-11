class CertificateModel {
  String? name;
  String? courseLanguage;
  String? courseLevel;
  String? certificateToken;
  String? teacherName;
  int? grade;

  CertificateModel(
      {this.name,
      this.courseLanguage,
      this.courseLevel,
      this.certificateToken,
      this.teacherName,
      this.grade});

  CertificateModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    courseLanguage = json['Course language'];
    courseLevel = json['Course level'];
    certificateToken = json['Certificate token'];
    teacherName = json['TeacherName'];
    grade = json['Grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Course language'] = this.courseLanguage;
    data['Course level'] = this.courseLevel;
    data['Certificate token'] = this.certificateToken;
    data['TeacherName'] = this.teacherName;
    data['Grade'] = this.grade;
    return data;
  }
}

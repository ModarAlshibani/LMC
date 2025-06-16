class TeacherModel {
  List<Teachers>? teachers;

  TeacherModel({this.teachers});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    if (json['Teachers'] != null) {
      teachers = <Teachers>[];
      json['Teachers'].forEach((v) {
        teachers!.add(new Teachers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teachers != null) {
      data['Teachers'] =
          this.teachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teachers {
  int? id;
  String? name;
  String? email;
  String? Description;
  String? Photo;

  Teachers({
    this.id,
    this.name,
    this.email,
    this.Description,
    this.Photo,
  });

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    Description = json['Description'];
    Photo = json['Photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['Photo'] = this.Photo;
    data['Description'] = this.Description;
    return data;
  }
}




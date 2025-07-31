class NoteModel {
  List<Notes>? notes;

  NoteModel({this.notes});

  NoteModel.fromJson(Map<String, dynamic> json) {
    if (json['Notes'] != null) {
      notes = <Notes>[];
      json['Notes'].forEach((v) {
        notes!.add(new Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notes != null) {
      data['Notes'] =
          this.notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes {
  int? id;
  String? content;
  int? studentId;

  Notes({
    this.id,
    this.content,
    this.studentId,
  });

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['Content'];
    studentId = json['StudentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Content'] = this.content;
    data['StudentId'] = this.studentId;
    return data;
  }
}




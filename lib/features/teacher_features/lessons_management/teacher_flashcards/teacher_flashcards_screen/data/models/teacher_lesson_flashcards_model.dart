class TeacherLessonFlashcardsModel {
  String? message;
  List<FlashCards>? flashCards;

  TeacherLessonFlashcardsModel({this.message, this.flashCards});

  TeacherLessonFlashcardsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['FlashCards'] != null) {
      flashCards = <FlashCards>[];
      json['FlashCards'].forEach((v) {
        flashCards!.add(new FlashCards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.flashCards != null) {
      data['FlashCards'] = this.flashCards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlashCards {
  int? id;
  int? lessonId;
  int? courseId;
  String? content;
  String? translation;
  String? createdAt;
  String? updatedAt;

  FlashCards(
      {this.id,
      this.lessonId,
      this.courseId,
      this.content,
      this.translation,
      this.createdAt,
      this.updatedAt});

  FlashCards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['LessonId'];
    courseId = json['CourseId'];
    content = json['Content'];
    translation = json['Translation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['LessonId'] = this.lessonId;
    data['CourseId'] = this.courseId;
    data['Content'] = this.content;
    data['Translation'] = this.translation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

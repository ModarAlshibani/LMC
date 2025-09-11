class TeacherFinalTestQuestionsModel {
  List<Questions>? questions;

  TeacherFinalTestQuestionsModel({this.questions});

  TeacherFinalTestQuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  int? testId;
  String? media;
  String? questionText;
  String? type;
  String? choices;
  String? correctAnswer;
  int? point;
  String? createdAt;
  String? updatedAt;

  Questions(
      {this.id,
      this.testId,
      this.media,
      this.questionText,
      this.type,
      this.choices,
      this.correctAnswer,
      this.point,
      this.createdAt,
      this.updatedAt});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['TestId'];
    media = json['Media'];
    questionText = json['QuestionText'];
    type = json['Type'];
    choices = json['Choices'];
    correctAnswer = json['CorrectAnswer'];
    point = json['Point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TestId'] = this.testId;
    data['Media'] = this.media;
    data['QuestionText'] = this.questionText;
    data['Type'] = this.type;
    data['Choices'] = this.choices;
    data['CorrectAnswer'] = this.correctAnswer;
    data['Point'] = this.point;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

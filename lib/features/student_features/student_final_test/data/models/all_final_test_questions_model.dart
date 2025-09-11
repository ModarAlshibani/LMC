class AllFinalTestQuestionsModel {
  String? message;
  List<Questions>? questions;

  AllFinalTestQuestionsModel({this.message, this.questions});

  AllFinalTestQuestionsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  int? testId;
  String? type;
  int? point;
  String? media;
  String? questionText;
  String? choices;

  Questions(
      {this.id,
      this.testId,
      this.type,
      this.point,
      this.media,
      this.questionText,
      this.choices});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['TestId'];
    type = json['Type'];
    point = json['Point'];
    media = json['Media'];
    questionText = json['QuestionText'];
    choices = json['Choices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TestId'] = this.testId;
    data['Type'] = this.type;
    data['Point'] = this.point;
    data['Media'] = this.media;
    data['QuestionText'] = this.questionText;
    data['Choices'] = this.choices;
    return data;
  }
}

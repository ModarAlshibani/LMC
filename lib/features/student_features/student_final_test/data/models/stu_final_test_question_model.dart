class StuFinalTestQuestionModel {
  String? message;
  Question? question;

  StuFinalTestQuestionModel({this.message, this.question});

  StuFinalTestQuestionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    return data;
  }
}

class Question {
  int? id;
  int? testId;
  String? type;
  int? point;
  String? media;
  String? questionText;
  String? choices;

  Question(
      {this.id,
      this.testId,
      this.type,
      this.point,
      this.media,
      this.questionText,
      this.choices});

  Question.fromJson(Map<String, dynamic> json) {
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

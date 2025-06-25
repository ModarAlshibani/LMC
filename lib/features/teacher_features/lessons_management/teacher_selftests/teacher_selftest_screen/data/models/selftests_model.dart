class SelfTestsModel {
  String? message;
  List<SelfTests>? selfTests;

  SelfTestsModel({this.message, this.selfTests});

  SelfTestsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['SelfTests'] != null) {
      selfTests = <SelfTests>[];
      json['SelfTests'].forEach((v) {
        selfTests!.add(new SelfTests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.selfTests != null) {
      data['SelfTests'] = this.selfTests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelfTests {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  List<Questions>? questions;

  SelfTests(
      {this.id, this.title, this.description, this.createdAt, this.questions});

  SelfTests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    description = json['Description'];
    createdAt = json['created_at'];
    if (json['Questions'] != null) {
      questions = <Questions>[];
      json['Questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['created_at'] = this.createdAt;
    if (this.questions != null) {
      data['Questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  int? selfTestId;
  Null? media;
  String? questionText;
  String? type;
  List<String>? choices;
  String? correctAnswer;
  String? createdAt;
  String? updatedAt;

  Questions(
      {this.id,
      this.selfTestId,
      this.media,
      this.questionText,
      this.type,
      this.choices,
      this.correctAnswer,
      this.createdAt,
      this.updatedAt});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selfTestId = json['SelfTestId'];
    media = json['Media'];
    questionText = json['QuestionText'];
    type = json['Type'];
    choices = json['Choices'].cast<String>();
    correctAnswer = json['CorrectAnswer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['SelfTestId'] = this.selfTestId;
    data['Media'] = this.media;
    data['QuestionText'] = this.questionText;
    data['Type'] = this.type;
    data['Choices'] = this.choices;
    data['CorrectAnswer'] = this.correctAnswer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

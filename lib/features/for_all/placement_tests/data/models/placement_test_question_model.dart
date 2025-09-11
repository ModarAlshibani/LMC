import 'answer_model.dart';

class QuestionModel {
  final int id;
  final String section;
  final String context;
  final String? media;
  final String questionText;
  final List<AnswerModel> answers;

  QuestionModel({
    required this.id,
    required this.section,
    required this.context,
    this.media,
    required this.questionText,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    var answersJson = json['Answers'] as List;
    List<AnswerModel> answers = answersJson
        .map((answer) => AnswerModel.fromJson(answer))
        .toList();

    return QuestionModel(
      id: json['id'],
      section: json['Section'],
      context: json['Context'],
      media: json['Media'],
      questionText: json['QuestionText'],
      answers: answers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Section': section,
      'Context': context,
      'Media': media,
      'QuestionText': questionText,
      'Answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }

  bool get isListeningQuestion => section.toLowerCase() == 'listening';
  bool get isReadingQuestion => section.toLowerCase() == 'reading';
  bool get isLanguageUseQuestion => section.toLowerCase() == 'language use';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'QuestionModel{id: $id, section: $section}';
}
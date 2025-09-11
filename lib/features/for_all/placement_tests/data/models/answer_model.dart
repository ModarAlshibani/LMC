class AnswerModel {
  final int id;
  final String answerText;

  AnswerModel({
    required this.id,
    required this.answerText,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      answerText: json['AnswerText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'AnswerText': answerText,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'AnswerModel{id: $id, answerText: $answerText}';
}
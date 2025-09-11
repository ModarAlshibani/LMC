class TestResultModel {
  final String message;
  final String level;
  final int totalScore;
  final int audioScore;
  final int readingScore;
  final int speakingScore;

  TestResultModel({
    required this.message,
    required this.level,
    required this.totalScore,
    required this.audioScore,
    required this.readingScore,
    required this.speakingScore,
  });

  factory TestResultModel.fromJson(Map<String, dynamic> json) {
    return TestResultModel(
      message: json['message'],
      level: json['Level'],
      totalScore: json['TotalScore'],
      audioScore: json['AudioScore'],
      readingScore: json['ReadingScore'],
      speakingScore: json['SpeakingScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'Level': level,
      'TotalScore': totalScore,
      'AudioScore': audioScore,
      'ReadingScore': readingScore,
      'SpeakingScore': speakingScore,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestResultModel && runtimeType == other.runtimeType && level == other.level;

  @override
  int get hashCode => level.hashCode;

  @override
  String toString() => 'TestResultModel{level: $level, totalScore: $totalScore}';
}

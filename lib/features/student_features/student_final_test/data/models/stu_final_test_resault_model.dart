class StuFinalTestResaultModel {
  String? message;
  int? finalTestScore; // ✅ Changed from String? to int?
  int? bonus;
  int? finalGrade;

  StuFinalTestResaultModel({
    this.message,
    this.finalTestScore,
    this.bonus,
    this.finalGrade,
  });

  StuFinalTestResaultModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    // Handle both string and int types for FinalTestScore
    if (json['FinalTestScore'] != null) {
      if (json['FinalTestScore'] is String) {
        finalTestScore = int.tryParse(json['FinalTestScore']);
      } else if (json['FinalTestScore'] is int) {
        finalTestScore = json['FinalTestScore'];
      }
    }
    bonus = json['Bonus'];
    finalGrade = json['FinalGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['FinalTestScore'] = this.finalTestScore;
    data['Bonus'] = this.bonus;
    data['FinalGrade'] = this.finalGrade;
    return data;
  }
}

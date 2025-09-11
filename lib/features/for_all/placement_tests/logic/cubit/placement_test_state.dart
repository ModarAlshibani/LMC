import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_question_model.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_resault_model.dart';

abstract class PlacementTestState extends Equatable {
  const PlacementTestState();

  @override
  List<Object?> get props => [];
}

class PlacementTestInitial extends PlacementTestState {}

class PlacementTestLoading extends PlacementTestState {}

class PlacementTestQuestionLoaded extends PlacementTestState {
  final QuestionModel question;
  final int questionNumber;
  final int? selectedAnswerId;
  final Duration remainingTime;

  const PlacementTestQuestionLoaded({
    required this.question,
    required this.questionNumber,
    this.selectedAnswerId,
    required this.remainingTime,
  });

  PlacementTestQuestionLoaded copyWith({
    QuestionModel? question,
    int? questionNumber,
    int? selectedAnswerId,
    Duration? remainingTime,
    bool clearSelectedAnswer = false, // Add this parameter
  }) {
    return PlacementTestQuestionLoaded(
      question: question ?? this.question,
      questionNumber: questionNumber ?? this.questionNumber,
      selectedAnswerId: clearSelectedAnswer 
          ? null 
          : (selectedAnswerId ?? this.selectedAnswerId),
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }

  @override
  List<Object?> get props => [
        question,
        questionNumber,
        selectedAnswerId,
        remainingTime,
      ];
}

class PlacementTestSubmitting extends PlacementTestState {}

class PlacementTestTimeUp extends PlacementTestState {}

class PlacementTestAutoSubmitting extends PlacementTestState {}

class PlacementTestCompleted extends PlacementTestState {
  final TestResultModel result;

  const PlacementTestCompleted({required this.result});

  @override
  List<Object> get props => [result];
}

class PlacementTestError extends PlacementTestState {
  final String message;

  const PlacementTestError({required this.message});

  @override
  List<Object> get props => [message];
}
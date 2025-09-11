// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_question_model.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_resault_model.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/cubit/placement_test_state.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/usecases/get_next_question_usecase.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/usecases/submit_answer_usecase.dart';

class PlacementTestCubit extends Cubit<PlacementTestState> {
  final GetNextQuestionUseCase getNextQuestionUseCase;
  final SubmitAnswerUseCase submitAnswerUseCase;

  PlacementTestCubit({
    required this.getNextQuestionUseCase,
    required this.submitAnswerUseCase,
  }) : super(PlacementTestInitial());

  // Test state
  int _currentQuestionNumber = 0;
  QuestionModel? _currentQuestion;
  int? _selectedAnswerId;
  
  // Timer related
  Timer? _timer;
  static const int _testDurationMinutes = 1;
  Duration _remainingTime = Duration(minutes: _testDurationMinutes);
  bool _isTimeUp = false;

  // Getters
  int get currentQuestionNumber => _currentQuestionNumber;
  QuestionModel? get currentQuestion => _currentQuestion;
  int? get selectedAnswerId => _selectedAnswerId;
  Duration get remainingTime => _remainingTime;
  bool get isTimeUp => _isTimeUp;

  Future<void> startTest() async {
    emit(PlacementTestLoading());
    _currentQuestionNumber = 0;
    _isTimeUp = false;
    _remainingTime = Duration(minutes: _testDurationMinutes);
    _startTimer();
    await _loadNextQuestion();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime = Duration(seconds: _remainingTime.inSeconds - 1);
        _updateStateWithTimer();
      } else {
        _onTimeUp();
      }
    });
  }

  void _updateStateWithTimer() {
    if (state is PlacementTestQuestionLoaded && _currentQuestion != null) {
      // Create a new state with the current timer and the actual selected answer from cubit
      emit(PlacementTestQuestionLoaded(
        question: _currentQuestion!,
        questionNumber: _currentQuestionNumber,
        selectedAnswerId: _selectedAnswerId, // Use the actual selected answer from cubit
        remainingTime: _remainingTime,
      ));
    }
  }

  Future<void> _onTimeUp() async {
    _timer?.cancel();
    _isTimeUp = true;
    
    // Show time up message briefly
    emit(PlacementTestTimeUp());
    
    // Wait a moment for user to see the message
    await Future.delayed(Duration(seconds: 3));
    
    // Start auto-submitting remaining questions
    await _autoSubmitRemainingQuestions();
  }

  Future<void> _autoSubmitRemainingQuestions() async {
    emit(PlacementTestAutoSubmitting());
    
    try {
      // Keep submitting null answers until we get the final result
      while (true) {
        if (_currentQuestion == null) {
          // Try to load next question first
          final result = await getNextQuestionUseCase.call();
          if (result is TestResultModel) {
            emit(PlacementTestCompleted(result: result));
            break;
          } else if (result is QuestionModel) {
            _currentQuestion = result;
          } else {
            emit(PlacementTestError(message: 'Failed to get final results'));
            break;
          }
        }

        // Submit null answer for current question (using null instead of -1)
        final success = await submitAnswerUseCase.call(
          questionId: _currentQuestion!.id,
          answerId: null, // Send null instead of -1
        );

        if (success) {
          // Try to load next question or get final result
          final result = await getNextQuestionUseCase.call();
          if (result is TestResultModel) {
            emit(PlacementTestCompleted(result: result));
            break;
          } else if (result is QuestionModel) {
            _currentQuestion = result;
            _selectedAnswerId = null;
          }
        } else {
          emit(PlacementTestError(message: 'Failed to finalize test'));
          break;
        }
      }
    } catch (e) {
      emit(PlacementTestError(message: 'Error finalizing test: ${e.toString()}'));
    }
  }

  Future<void> _loadNextQuestion() async {
    try {
      final result = await getNextQuestionUseCase.call();
      
      if (result is QuestionModel) {
        _currentQuestion = result;
        _currentQuestionNumber++;
        _selectedAnswerId = null; // Reset selected answer for new question
        emit(PlacementTestQuestionLoaded(
          question: result,
          questionNumber: _currentQuestionNumber,
          selectedAnswerId: null, // Explicitly set to null for new question
          remainingTime: _remainingTime,
        ));
      } else if (result is TestResultModel) {
        _timer?.cancel();
        emit(PlacementTestCompleted(result: result));
      }
    } catch (e) {
      emit(PlacementTestError(message: e.toString()));
    }
  }

  void selectAnswer(int answerId) {
    if (state is PlacementTestQuestionLoaded && !_isTimeUp) {
      _selectedAnswerId = answerId;
      emit(PlacementTestQuestionLoaded(
        question: _currentQuestion!,
        questionNumber: _currentQuestionNumber,
        selectedAnswerId: answerId, // Explicitly pass the selected answer
        remainingTime: _remainingTime,
      ));
    }
  }

  Future<void> submitAnswer() async {
    if (_currentQuestion == null) {
      emit(PlacementTestError(message: 'No question available'));
      return;
    }

    if (_isTimeUp) {
      emit(PlacementTestError(message: 'Time is up! Test is being finalized.'));
      return;
    }

    emit(PlacementTestSubmitting());

    try {
      // Send the actual selected answer ID or null for skipped questions
      final success = await submitAnswerUseCase.call(
        questionId: _currentQuestion!.id,
        answerId: _selectedAnswerId, // Don't convert null to -1, send null as is
      );

      if (success) {
        await _loadNextQuestion();
      } else {
        emit(PlacementTestError(message: 'Failed to submit answer'));
      }
    } catch (e) {
      emit(PlacementTestError(message: e.toString()));
    }
  }

  void resetTest() {
    _timer?.cancel();
    _currentQuestionNumber = 0;
    _currentQuestion = null;
    _selectedAnswerId = null;
    _remainingTime = Duration(minutes: _testDurationMinutes);
    _isTimeUp = false;
    emit(PlacementTestInitial());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  @override
  void onChange(Change<PlacementTestState> change) {
    super.onChange(change);
    print('PlacementTestCubit: ${change.currentState} -> ${change.nextState}');
  }
}
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/data/models/course_student_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/usecases/get_students_names_usecase.dart';

import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/logic/usecase/taecher_lesson_flashcards_usecase.dart';

part 'get_students_names_state.dart';

class GetStudentsNamesCubit extends Cubit<GetStudentsNamesState> {
  final GetStudentsNamesUsecase getStudentsNamesUsecase;

  GetStudentsNamesCubit(this.getStudentsNamesUsecase) : super(GetStudentsNamesInitial());

  Future<void> fetchStudentsNames(int lessonId ) async {
    emit(GetStudentsNamesLoading());

    try {
      final getStudentsNames = await getStudentsNamesUsecase.execute(lessonId);
      emit(GetStudentsNamesSuccess(getStudentsNames));
    } catch (error) {
      emit(GetStudentsNamesFailure(error.toString()));
    }
  }
}

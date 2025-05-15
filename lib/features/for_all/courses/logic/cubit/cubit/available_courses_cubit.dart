import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/courses/data/models/available_courses_model.dart';
import 'package:lmc_app/features/for_all/courses/logic/usecases/available_courses_usecase.dart';


part 'available_courses_state.dart';

class AvailableCoursesCubit extends Cubit<AvailableCoursesState> {
  final GetAvailableCoursesUseCase getAvailableCoursesUseCase;

  AvailableCoursesCubit(this.getAvailableCoursesUseCase) : super(AvailableCoursesInitial());

  Future<void> fetchAvailableCourses() async {
    emit(AvailableCoursesLoading());

    try {
      final availableCourses = await getAvailableCoursesUseCase.execute();
      emit(AvailableCoursesSuccess(availableCourses));
    } catch (error) {
      emit(AvailableCoursesFailure(error.toString()));
    }
  }
}

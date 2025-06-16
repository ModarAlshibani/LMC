import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/teacher_model.dart';
import '../usecases/get_teachers_list.dart';

part 'show_teachers_state.dart';

class ShowTeachersCubit extends Cubit<ShowTeachersState> {
  final GetTeachersListUsecase getTeachersListUsecase;

  ShowTeachersCubit(this.getTeachersListUsecase) : super(ShowTeachersInitial());

  Future<void> fetchAllTeachers() async {
    emit(ShowTeachersLoading());

    try {
      final teachers = await getTeachersListUsecase.execute();
      emit(ShowTeachersSuccess(teachers));
    } catch (error) {
      emit(ShowTeachersFailure(error.toString()));
    }
  }
}

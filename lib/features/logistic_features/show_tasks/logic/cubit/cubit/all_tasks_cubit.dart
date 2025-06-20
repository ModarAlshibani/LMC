import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/all_tasks_model.dart';
import '../../usecases/all_tasks_usecases.dart';

part 'all_tasks_state.dart';

class AllTasksCubit extends Cubit<AllTasksState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  AllTasksCubit(this.getAllTasksUseCase) : super(AllTasksInitial());

  Future<void> fetchAllTasks() async {
    emit(AllTasksLoading());

    try {
      final tasks = await getAllTasksUseCase.execute();
      emit(AllTasksSuccess(tasks));
    } catch (error) {
      emit(AllTasksFailure(error.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/announsments/data/models/all_announsments.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/data/models/all_tasks_model.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/usecases/all_tasks_usecases.dart';

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

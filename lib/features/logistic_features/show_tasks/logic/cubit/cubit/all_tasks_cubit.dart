// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
<<<<<<< Updated upstream:lib/features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart
import 'package:lmc_app/features/logistic_features/show_tasks/data/models/all_tasks_model.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/usecases/all_tasks_usecases.dart';
=======
import 'package:lmc_app/features/logistic_app/show_tasks/data/models/all_tasks_model.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/logic/usecases/all_tasks_usecases.dart';
>>>>>>> Stashed changes:lib/features/logistic_app/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart

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

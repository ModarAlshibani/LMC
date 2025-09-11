import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/data/models/teacher_schedule_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/logic/usecases/show_schedule_usecase.dart';

part 'show_schedule_state.dart';

class ShowScheduleCubit extends Cubit<ShowScheduleState> {
  final GetShowScheduleUseCase getShowScheduleUseCase;

  ShowScheduleCubit(this.getShowScheduleUseCase) : super(ShowScheduleInitial());

  Future<void> fetchShowSchedule(String date) async {
    emit(ShowScheduleLoading());

    try {
      final schedule = await getShowScheduleUseCase.execute(date);
      if (!isClosed) emit(ShowScheduleSuccess(schedule));
    } catch (error) {
      if (!isClosed) emit(ShowScheduleFailure(error.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/announsments/data/models/all_announsments.dart';
import 'package:lmc_app/features/announsments/logic/usecases/get_all_announcements_usecase.dart';

part 'all_announcements_state.dart';

class AllAnnouncementsCubit extends Cubit<AllAnnouncementsState> {
  final GetAllAnnouncementsUseCase getAllAnnouncementsUseCase;

  AllAnnouncementsCubit(this.getAllAnnouncementsUseCase) : super(AllAnnouncementsInitial());

  Future<void> fetchAllAnnouncements() async {
    emit(AllAnnouncementsLoading());

    try {
      final announcements = await getAllAnnouncementsUseCase.execute();
      emit(AllAnnouncementsSuccess(announcements));
    } catch (error) {
      emit(AllAnnouncementsFailure(error.toString()));
    }
  }
}

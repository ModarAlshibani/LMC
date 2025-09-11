import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/data/private_course_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/cubit/private_course_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/add_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/delete_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/edit_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/get_private_course_usecase.dart';

class PrivateCourseCubit extends Cubit<PrivateCourseState> {
  final GetPrivateCourseUsecase getPrivateCourseUsecase;
  final AddPrivateCourseUsecase addPrivateCourseUsecase;
  final UpdatePrivateCourseUsecase updatePrivateCourseUsecase;
  final DeletePrivateCourseUsecase deletePrivateCourseUsecase; // FIXED: Moved to proper position

  PrivateCourseCubit({
    required this.getPrivateCourseUsecase,
    required this.addPrivateCourseUsecase,
    required this.updatePrivateCourseUsecase,
    required this.deletePrivateCourseUsecase, // FIXED: Added to constructor
  }) : super(PrivateCourseInitial());

  Future<void> fetchPC() async {
    emit(PrivateCourseLoading());
    try {
      final requests = await getPrivateCourseUsecase.execute(); // Returns List<Request>
      emit(PrivateCourseSuccess(requests)); // FIXED: Pass the list directly
    } catch (error) {
      emit(PrivateCourseFailure(error.toString()));
    }
  }
   
  Future<void> addPC(Request pc) async {
    emit(PrivateCourseLoading());
    try {
      final result = await addPrivateCourseUsecase.execute(pc);
      if (result) {
        await fetchPC(); // FIXED: Added await
      } else {
        emit(const PrivateCourseFailure("Failed to add private course request."));
      }
    } catch (e) {
      emit(PrivateCourseFailure(e.toString()));
    }
  }

  Future<void> deletePC(int pcId) async {
    emit(PrivateCourseLoading());
    try {
      final result = await deletePrivateCourseUsecase.execute(pcId);
      if (result) {
        await fetchPC();
      } else {
        emit(const PrivateCourseFailure("Failed to delete private course request."));
      }
    } catch (e) {
      emit(PrivateCourseFailure(e.toString()));
    }
  }

  Future<void> editPC(Request pc) async {
    emit(PrivateCourseLoading());
    try {
      final result = await updatePrivateCourseUsecase.execute(pc);
      if (result) {
        await fetchPC();
      } else {
        emit(const PrivateCourseFailure("Failed to update private course request."));
      }
    } catch (e) {
      emit(PrivateCourseFailure(e.toString()));
    }
  }
}
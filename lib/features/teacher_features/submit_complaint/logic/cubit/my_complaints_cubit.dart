import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lmc_app/features/teacher_features/submit_complaint/data/models/my_complaints_model.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/my_complaints_usecase.dart';

part 'my_complaints_state.dart';

class MyComplaintsCubit extends Cubit<MyComplaintsState> {
  final MyComplaintsUsecase myComplaintsUsecase;

  MyComplaintsCubit(this.myComplaintsUsecase) : super(MyComplaintsInitial());

  Future<void> fetchMyComplaints() async {
 
    emit(MyComplaintsLoading());

    try {
      final myComplaints = await myComplaintsUsecase.execute();
      emit(MyComplaintsSuccess(myComplaints));
    } catch (error) {
      emit(MyComplaintsFailure(error.toString()));
    }
  }
}

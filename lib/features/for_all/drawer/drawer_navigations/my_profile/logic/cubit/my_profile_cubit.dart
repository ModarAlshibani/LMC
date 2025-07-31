// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/usecases/my_profile_usecase.dart';



class MyProfileCubit extends Cubit<MyProfileState> {
  final GetMyProfileUsecase getMyProfileUsecase;

  MyProfileCubit(this.getMyProfileUsecase) : super(MyProfileInitial());

  Future<void> fetchMyInfo() async {
    if (isClosed) return;
    emit(MyProfileLoading());

    try {
      final myInfo = await getMyProfileUsecase.execute();
      if (!isClosed) emit(MyProfileSuccess(myInfo));
    } catch (error) {
      if (!isClosed) emit(MyProfileFailure(error.toString()));
    }
  }
}

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/usecases/edit_my_profile_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/usecases/my_profile_usecase.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';



class MyProfileCubit extends Cubit<MyProfileState> {
  final GetMyProfileUsecase getMyProfileUsecase;
  final EditMyInfoUsecase editMyInfoUsecase;

  MyProfileCubit(this.getMyProfileUsecase, this.editMyInfoUsecase) : super(MyProfileInitial());

  Future<void> fetchMyInfo() async {
    if (isClosed) return;
    emit(MyProfileLoading());

    try {
      final myInfo = await getMyProfileUsecase.execute();
      if (!isClosed) emit(MyProfileSuccess(myInfo as User));
    } catch (error) {
      if (!isClosed) emit(MyProfileFailure(error.toString()));
    }
  }

  Future<void> editMyInfo({
    String? description,  
    String? photoFilePath, 
  }) async {
    emit(MyProfileLoading());
    try {
      await editMyInfoUsecase.execute(
        description: description,
        photoFilePath: photoFilePath,
      );

       await fetchMyInfo();
    } catch (e) {
      if (!isClosed) emit(MyProfileFailure(e.toString()));
    }
}
}
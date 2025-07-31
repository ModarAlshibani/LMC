// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/cubit/;mc_info_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/usecases/lmc_info_usecase.dart';


class LmcInfoCubit extends Cubit<LmcInfoState> {
  final GetLmcInfoUsecase getLmcInfoUsecase;

  LmcInfoCubit(this.getLmcInfoUsecase) : super(LmcInfoInitial());

  Future<void> fetchLmcInfo() async {
  if (isClosed) return;
  emit(LmcInfoLoading());

  try {
    final lmcInfo = await getLmcInfoUsecase.execute();
    if (!isClosed) emit(LmcInfoSuccess(lmcInfo));
  } catch (error) {
    if (!isClosed) emit(LmcInfoFailure(error.toString()));
  }
}
}
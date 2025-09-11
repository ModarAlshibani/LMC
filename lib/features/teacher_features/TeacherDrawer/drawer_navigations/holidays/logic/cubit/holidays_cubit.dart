// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/cubit/holidays_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/usecases/get_holidays_usecase.dart';


class HolidaysCubit extends Cubit<HolidaysState> {
  final GetHolidaysUsecase getHolidaysUsecase;

  HolidaysCubit(this.getHolidaysUsecase) : super(HolidaysInitial());

  Future<void> fetchHolidays() async {
  if (isClosed) return;
  emit(HolidaysLoading());

  try {
    final holidays = await getHolidaysUsecase.execute();
    if (!isClosed) emit(HolidaysSuccess(holidays));
  } catch (error) {
    if (!isClosed) emit(HolidaysFailure(error.toString()));
  }
}
}
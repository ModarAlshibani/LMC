// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/cubit/language_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/usecases/language_usecase.dart';


class LanguageCubit extends Cubit<LanguageState> {
  final GetLanguageUsecase getLanguageUsecase;

  LanguageCubit(this.getLanguageUsecase) : super(LanguageInitial());

  Future<void> fetchLanguages() async {
    emit(LanguageLoading());

    try {
      final language = await getLanguageUsecase.execute();
      emit(LanguageSuccess(language));
    } catch (error) {
      emit(LanguageFailure(error.toString()));
    }
  }
}
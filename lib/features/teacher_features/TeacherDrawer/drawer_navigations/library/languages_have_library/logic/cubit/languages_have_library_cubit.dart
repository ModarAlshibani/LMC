
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/cubit/languages_have_library_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/usecases/languages_have_library_usecase.dart';


class LanguagesHaveLibraryCubit extends Cubit<LanguagesHaveLibraryState> {
  final GetLanguagesHaveLibraryUsecase getLanguagesHaveLibraryUsecase;

  LanguagesHaveLibraryCubit(this.getLanguagesHaveLibraryUsecase) : super(LanguagesHaveLibraryInitial());

  Future<void> fetchLanguages() async {
    emit(LanguagesHaveLibraryLoading());

    try {
      final languagesHaveLibrary = await getLanguagesHaveLibraryUsecase.execute();
      emit(LanguagesHaveLibrarySuccess(languagesHaveLibrary));
    } catch (error) {
      emit(LanguagesHaveLibraryFailure(error.toString()));
    }
  }
}

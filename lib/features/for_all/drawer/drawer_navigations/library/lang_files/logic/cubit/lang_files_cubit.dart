
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/cubit/lang_files_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/usecases/lang_files_usecase.dart';


class LangFilesCubit extends Cubit<LangFilesState> {
  final GetLangFilesUsecase getLangFilesUsecase;

  LangFilesCubit(this.getLangFilesUsecase) : super(LangFilesInitial());

  Future<void> fetchFiles(int languageId) async {
    emit(LangFilesLoading());

    try {
      final langFiles = await getLangFilesUsecase.execute(languageId);
      emit(LangFilesSuccess(langFiles));
    } catch (error) {
      emit(LangFilesFailure(error.toString()));
    }
  }
}

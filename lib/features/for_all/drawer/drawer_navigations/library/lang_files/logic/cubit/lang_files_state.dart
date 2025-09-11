
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/data/lang_files_model.dart';

abstract class LangFilesState extends Equatable {
  const LangFilesState();

  @override
  List<Object?> get props => [];
}

class LangFilesInitial extends LangFilesState {}

class LangFilesLoading extends LangFilesState {}

class LangFilesSuccess extends LangFilesState {
  final LangFilesModel langFiles;

  const LangFilesSuccess(this.langFiles);

  @override
  List<Object?> get props => [langFiles];
}

class LangFilesFailure extends LangFilesState {
  final String error;

  const LangFilesFailure(this.error);

  @override
  List<Object?> get props => [error];
}

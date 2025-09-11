
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/data/languages_have_library_model.dart';

abstract class LanguagesHaveLibraryState extends Equatable {
  const LanguagesHaveLibraryState();

  @override
  List<Object?> get props => [];
}

class LanguagesHaveLibraryInitial extends LanguagesHaveLibraryState {}

class LanguagesHaveLibraryLoading extends LanguagesHaveLibraryState {}

class LanguagesHaveLibrarySuccess extends LanguagesHaveLibraryState {
  final LanguagesHaveLibraryModel languagesHaveLibrary;

  const LanguagesHaveLibrarySuccess(this.languagesHaveLibrary);

  @override
  List<Object?> get props => [languagesHaveLibrary];
}

class LanguagesHaveLibraryFailure extends LanguagesHaveLibraryState {
  final String error;

  const LanguagesHaveLibraryFailure(this.error);

  @override
  List<Object?> get props => [error];
}


import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/data/model/language_model.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object?> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageSuccess extends LanguageState {
  final LanguageModel language;

  const LanguageSuccess(this.language);

  @override
  List<Object?> get props => [language];
}

class LanguageFailure extends LanguageState {
  final String error;

  const LanguageFailure(this.error);

  @override
  List<Object?> get props => [error];
}

part of 'get_students_names_cubit.dart';

abstract class GetStudentsNamesState extends Equatable {
  const GetStudentsNamesState();

  @override
  List<Object?> get props => [];
}

class GetStudentsNamesInitial extends GetStudentsNamesState {}

class GetStudentsNamesLoading extends GetStudentsNamesState {}

class GetStudentsNamesSuccess extends GetStudentsNamesState {
  final List<Students> getStudentsNames;

  const GetStudentsNamesSuccess(this.getStudentsNames);

  @override
  List<Object?> get props => [getStudentsNames];
}

class GetStudentsNamesFailure extends GetStudentsNamesState {
  final String error;

  const GetStudentsNamesFailure(this.error);

  @override
  List<Object?> get props => [error];
}

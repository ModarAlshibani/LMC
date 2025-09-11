import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/data/private_course_model.dart';

abstract class PrivateCourseState extends Equatable {
  const PrivateCourseState();

  @override
  List<Object?> get props => [];
}

class PrivateCourseInitial extends PrivateCourseState {}

class PrivateCourseLoading extends PrivateCourseState {}

class PrivateCourseSuccess extends PrivateCourseState {
  final List<Request> pc;

  const PrivateCourseSuccess(this.pc);

  @override
  List<Object?> get props => [pc];
}

class PrivateCourseFailure extends PrivateCourseState {
  final String error;

  const PrivateCourseFailure(this.error);

  @override
  List<Object?> get props => [error];
}

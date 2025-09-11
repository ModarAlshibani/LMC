
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/data/holidays_model.dart';

abstract class HolidaysState extends Equatable {
  const HolidaysState();

  @override
  List<Object?> get props => [];
}

class HolidaysInitial extends HolidaysState {}

class HolidaysLoading extends HolidaysState {}

class HolidaysSuccess extends HolidaysState {
  final HolidaysModel holidays;

  const HolidaysSuccess(this.holidays);

  @override
  List<Object?> get props => [holidays];
}

class HolidaysFailure extends HolidaysState {
  final String error;

  const HolidaysFailure(this.error);

  @override
  List<Object?> get props => [error];
}

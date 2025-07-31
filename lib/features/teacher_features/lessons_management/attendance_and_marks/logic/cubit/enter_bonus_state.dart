part of 'enter_bonus_cubit.dart';

abstract class EnterBonusState extends Equatable {
  const EnterBonusState();

  @override
  List<Object?> get props => [];
}

class EnterBonusInitial extends EnterBonusState {}

class EnterBonusLoading extends EnterBonusState {}

class EnterBonusSuccess extends EnterBonusState {}

class EnterBonusFailure extends EnterBonusState {
  final String error;

  const EnterBonusFailure(this.error);

  @override
  List<Object?> get props => [error];
}
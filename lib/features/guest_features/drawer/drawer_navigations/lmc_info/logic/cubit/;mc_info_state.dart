
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/data/model/lmc_info_model.dart';

abstract class LmcInfoState extends Equatable {
  const LmcInfoState();

  @override
  List<Object?> get props => [];
}

class LmcInfoInitial extends LmcInfoState {}

class LmcInfoLoading extends LmcInfoState {}

class LmcInfoSuccess extends LmcInfoState {
  final LmcInfoModel lmcInfo;

  const LmcInfoSuccess(this.lmcInfo);

  @override
  List<Object?> get props => [lmcInfo];
}

class LmcInfoFailure extends LmcInfoState {
  final String error;

  const LmcInfoFailure(this.error);

  @override
  List<Object?> get props => [error];
}

part of 'all_announcements_cubit.dart';

abstract class AllAnnouncementsState extends Equatable {
  const AllAnnouncementsState();

  @override
  List<Object?> get props => [];
}

class AllAnnouncementsInitial extends AllAnnouncementsState {}

class AllAnnouncementsLoading extends AllAnnouncementsState {}

class AllAnnouncementsSuccess extends AllAnnouncementsState {
  final List<Announcements> announcements;

  const AllAnnouncementsSuccess(this.announcements);

  @override
  List<Object?> get props => [announcements];
}

class AllAnnouncementsFailure extends AllAnnouncementsState {
  final String error;

  const AllAnnouncementsFailure(this.error);

  @override
  List<Object?> get props => [error];
}

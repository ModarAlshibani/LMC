import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/announsments/ui/widgets/announcement_outside.dart';

class AnnouncementsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AllAnnouncementsCubit>().fetchAllAnnouncements();
    return BlocBuilder<AllAnnouncementsCubit, AllAnnouncementsState>(
      builder: (context, state) {
        if (state is AllAnnouncementsLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is AllAnnouncementsFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is AllAnnouncementsSuccess) {
          print("state is: $state");
          // Only show the first 6 announcements
          final announcements = state.announcements.take(6).toList();
          return ListView.builder(
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              return AnnouncementOutside(
                title: announcements[index].title ?? 'No Title',
                image: announcements[index].photo!.replaceAll(
                  'localhost',
                  ApiConstants.ip,
                ),
                content: announcements[index].content ?? 'No Content',
              );
            },
          );
        }
        return Center(child: Text('No announcements found.'));
      },
    );
  }
}

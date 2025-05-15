import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/announsments/ui/widgets/announcement_outside.dart';
import 'package:lmc_app/features/for_all/courses/logic/cubit/cubit/available_courses_cubit.dart';

class AvailableCoursesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AvailableCoursesCubit>().fetchAvailableCourses();
    return BlocBuilder<AvailableCoursesCubit, AvailableCoursesState>(
      builder: (context, state) {
        if (state is AvailableCoursesLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is AvailableCoursesFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is AvailableCoursesSuccess) {
          print("state is: $state");
          final coursesList = state.availableCourses.toList();
          return ListView.builder(
            itemCount: coursesList.length,
            itemBuilder: (context, index) {
              return AnnouncementOutside(
                title: coursesList[index].level ?? 'No Level',
                image: coursesList[index].photo?.replaceAll('localhost', ApiConstants.ip),
                content: coursesList[index].description ?? 'No Content',
              );
            },
          );
        }
        return Center(child: Text('No announcements found.'));
      },
    );
  }
}

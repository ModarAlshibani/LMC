import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/features/for_all/announsments/ui/widgets/announcement_outside.dart';
import 'package:lmc_app/features/for_all/available_courses/data/models/available_courses_model.dart';
import 'package:lmc_app/features/for_all/available_courses/logic/cubit/cubit/available_courses_cubit.dart';

class AvailableCoursesList extends StatelessWidget {
  final String searchQuery;

  
  final List<String Function(AvailableCourses)> fields;

  const AvailableCoursesList({
    super.key,
    this.searchQuery = '',
    this.fields = const [],
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableCoursesCubit, AvailableCoursesState>(
      builder: (context, state) {
        if (state is AvailableCoursesInitial || state is AvailableCoursesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AvailableCoursesFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        if (state is AvailableCoursesSuccess) {
          final courses = state.availableCourses;

          // tokenized query (AND across tokens)
          final tokens = _tokenize(searchQuery);

          // use provided field selectors or sensible defaults
          final getters = fields.isNotEmpty
              ? fields
              : <String Function(AvailableCourses)>[
                  (c) => c.teacherName ?? '',
                  (c) => c.description ?? '',
                ];

          final filtered = tokens.isEmpty
              ? courses
              : courses.where((c) => _matches(c, tokens, getters)).toList();

          if (filtered.isEmpty) {
            return const Center(child: Text('No results found!'));
          }

          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final item = filtered[i];
              return AnnouncementOutside(
                // show whatever you want here — keeping teacherName + description like your current UI
                title: item.teacherName ?? 'No Teacher',
                image: item.photo?.replaceAll('localhost', ApiConstants.ip),
                content: item.description ?? 'No Content',
              );
            },
          );
        }

        return const Center(child: Text('No courses found.'));
      },
    );
  }

  List<String> _tokenize(String input) {
    final s = input.trim().toLowerCase();
    if (s.isEmpty) return const [];
    return s.split(RegExp(r'\s+'));
  }

  bool _matches(
    AvailableCourses c,
    List<String> tokens,
    List<String Function(AvailableCourses)> getters,
  ) {
    final fields = getters
        .map((g) => (g(c)).toLowerCase())
        .where((v) => v.isNotEmpty)
        .toList();

    // every token must be found in at least one field
    return tokens.every((t) => fields.any((v) => v.contains(t)));
  }
}

// lib/features/student_features/show_teachers/ui/widgets/teachers_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';
import 'package:lmc_app/features/student_features/show_teachers/ui/widgets/teacher_outside.dart';

class TeachersList extends StatelessWidget {
  final List<Teachers> teachers;
  const TeachersList({super.key, required this.teachers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 145 / 180,
      ),
      itemCount: teachers.length,
      itemBuilder: (_, i) => TeacherOutside(teacher: teachers[i]),
    );
  }
}

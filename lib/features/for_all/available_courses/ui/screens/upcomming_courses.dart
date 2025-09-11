import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/features/for_all/available_courses/ui/widgets/available_courses_list.dart';
import 'package:lmc_app/features/guest_features/guest_homePage/ui/widgets/top_container.dart';
import 'package:lmc_app/features/for_all/available_courses/logic/cubit/cubit/available_courses_cubit.dart';
import 'package:lmc_app/features/for_all/available_courses/data/models/available_courses_model.dart' as model;

class AvailableCourses extends StatefulWidget {
  const AvailableCourses({super.key});
  @override
  State<AvailableCourses> createState() => _AvailableCoursesState();
}

class _AvailableCoursesState extends State<AvailableCourses> {
  String _query = '';

  @override
  void initState() {
    super.initState();
    context.read<AvailableCoursesCubit>().fetchAvailableCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: Stack(
        children: [
          Positioned(top: -110.h, left: -30.w, right: -30.w, child: TopContainer(height: 300.h, border: true)),
          Positioned(
            top: 90.h, left: 50.w, right: 50.w,
            child: Center(
              child: Text("Available Courses", style: TextStyle(color: AppColors.backgroundColor, fontSize: 35, fontWeight: FontWeight.w800)),
            ),
          ),
          Positioned(
            top: 210.h, left: 30, right: 30,
            child: GeneralTextFormField(
              fillColor: AppColors.backgroundColor,
              hintText: "Search for Courses",
              hintTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.lmcBlue),
              prefixIcon: Icon(Icons.search, size: 30, color: AppColors.lmcBlue),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0), borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.lmcOrange.withOpacity(0.6), width: 1.3), borderRadius: BorderRadius.circular(30)),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Positioned(
            top: 280.h, right: 20.w, left: 20.w, bottom: 20,
            child: AvailableCoursesList(
              searchQuery: _query,
              fields: <String Function(model.AvailableCourses)>[
                (c) => c.teacherName ?? '',
                (c) => c.description ?? '',
              ],
            ),
          ),
        ],
      ),
    );
  }
}

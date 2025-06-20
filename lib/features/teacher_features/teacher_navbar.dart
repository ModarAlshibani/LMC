import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/di/dependency_injection.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/available_courses/logic/cubit/cubit/available_courses_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/logic/cubit/my_courses_teacher_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/ui/screens/my_courses_teacher_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_homepage/teacher_homepage.dart';

class TeacherNavBar extends StatefulWidget {
  @override
  _TeacherNavBarState createState() => _TeacherNavBarState();
}

class _TeacherNavBarState extends State<TeacherNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => getIt<AllAnnouncementsCubit>(),
      child: TeacherHomepage(),
    ),
    BlocProvider(
      create: (context) => getIt<MyCoursesTeacherCubit>(),
      child: MyCoursesTeacherScreen(),
    ),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColors.lmcBlue,
        buttonBackgroundColor: AppColors.lmcOrange,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: AppColors.backgroundColor),
          Icon(Icons.play_lesson, size: 30, color: AppColors.backgroundColor),
          Icon(Icons.person, size: 30, color: AppColors.backgroundColor),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/dependency_injection.dart';
import '../../core/theming/colors.dart';
import '../for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'notes/ui/screens/my_notes.dart';
import 'home_page/ui/screen/student_homePage_screen.dart';
import 'my_courses/show_my_courses/logic/cubit/student_my_courses_cubit.dart';
import 'my_courses/show_my_courses/ui/screens/student_my_courses_screen.dart';
import 'package:lmc_app/features/for_all/drawer/ui/my_drawer.dart'; // adjust if needed

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int page = 1;
  bool isDrawerOpen = false;

  GlobalKey<CurvedNavigationBarState> _navigationKey = GlobalKey();
  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  static List<Widget> widgetsList = <Widget>[
    BlocProvider(
      create: (context) => getIt<StudentMyCoursesCubit>(),
      child: StudentMyCoursesScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<AllAnnouncementsCubit>(),
      child: StudentHomePageScreen(),
    ),
    MyNotes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsList.elementAt(page),
      drawer: MyDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _navigationKey,
        index: page,
        items: <Widget>[
          Icon(Icons.play_lesson_outlined, color: AppColors.backgroundColor),
          Icon(Icons.home, color: AppColors.backgroundColor),
          Icon(Icons.sticky_note_2_sharp, color: AppColors.backgroundColor),
        ],
        height: 70,
        color: AppColors.lmcBlue,
        buttonBackgroundColor: AppColors.lmcOrange,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),

    );
  }
}

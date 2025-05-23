import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/my_notes.dart';
import 'package:lmc_app/features/student_features/student_homePage_screen.dart';
import 'package:lmc_app/features/student_features/student_my_courses.dart';
import 'package:lmc_app/features/for_all/drawer/ui/my_drawer.dart'; // adjust if needed

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int page = 0;

  GlobalKey<CurvedNavigationBarState> _navigationKey = GlobalKey();

  static List<Widget> widgetsList = <Widget>[
    StudentMyCourses(),
    StudentHomePageScreen(),
    MyNotes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          widgetsList.elementAt(page),
        ],
      ),

      bottomNavigationBar: Stack(
        children: [
          CurvedNavigationBar(
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

        ],
      ),

    );
  }
}

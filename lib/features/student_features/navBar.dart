import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/di/dependency_injection.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/login/logic/cubit/logout_cubit.dart';
import 'package:lmc_app/features/for_all/login/logic/cubit/logout_state.dart';
import 'package:lmc_app/features/student_features/notes/ui/screens/my_notes.dart';
import 'package:lmc_app/features/student_features/home_page/ui/screen/student_homePage_screen.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/logic/cubit/student_my_courses_cubit.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/ui/screens/student_my_courses_screen.dart';
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
    return WillPopScope(
    onWillPop: () async {
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit App"),
          content: Text("Are you sure you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Yes"),
            ),
          ],
        ),
      );
       if (shouldExit ?? false) {
       SystemNavigator.pop(); // ✅ exits app properly on Android
  }

  return false; // prevents further back navigation
    },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/loginScreen',
            (route) => false,
          );
        } else if (state is AuthLogoutFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout failed: ${state.error}')),
          );
        }
        },
        child: Scaffold(
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
        ),
      ),
    );
  }
}

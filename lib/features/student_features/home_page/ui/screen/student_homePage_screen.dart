import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/announsments/ui/widgets/announcements_list.dart';
import 'package:lmc_app/features/for_all/drawer/ui/my_drawer.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/widgets/general_text_form_field.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../guest_features/guest_homePage/ui/widgets/glass_inkwell.dart';
import '../../../../guest_features/guest_homePage/ui/widgets/top_container.dart';

class StudentHomePageScreen extends StatefulWidget {
  const StudentHomePageScreen({super.key});

  @override
  State<StudentHomePageScreen> createState() => _StudentHomePageScreenState();
}

class _StudentHomePageScreenState extends State<StudentHomePageScreen> {
  bool isDrawerOpen = false;
  // late Future<User> user;

  @override
  void initState() {
    super.initState();
    // user = ApiService().getUserName();
  }

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: -0,
                  left: -140,
                  right: -140,
                  child: TopContainer(height: 300.h),
                ),

                Positioned(
                  top: 20.h,
                  left: 10.h,
                  child: SizedBox(
                    width: 350.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: toggleDrawer,
                              icon: Icon(Icons.menu),
                              iconSize: 30,
                              color: AppColors.backgroundColor,
                            ),
                            // FutureBuilder<User>(
                            //     future: user,
                            //     builder: (context, userInfo){
                            //       if(userInfo.hasData){
                            //         return Text("Hi ${userInfo.data!.name}...",
                            //           style: TextStyle(
                            //               color: AppColors.backgroundColor,
                            //               fontSize: 25,
                            //               fontWeight: FontWeight.w900),);
                            //       } else if(userInfo.hasError){
                            //         return Text("${userInfo.error}");
                            //       }else{
                            //         return const Center(child: CircularProgressIndicator(),);
                            //       }
                            //     }
                            // ),
                            Icon(
                              Icons.circle_notifications_outlined,
                              size: 50,
                              color: AppColors.lmcOrange,
                            ),
                          ],
                        ),
                        Text(
                          "Welcome to",
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "LMC !",
                          style: TextStyle(
                            fontSize: 50.sp,
                            color: AppColors.lmcOrange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Search bar
                Positioned(
                  top: 210.h,
                  left: 30,
                  right: 30,
                  child: GeneralTextFormField(
                    fillColor: AppColors.backgroundColor,
                    hintText: "Search",
                    hintTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lmcBlue,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: AppColors.lmcBlue,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lmcOrange.withOpacity(0.6),
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                // Glass buttons row
                Positioned(
                  top: 300.h,
                  left: 10.w,
                  right: 10.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GlassInkwell(
                        firstRow: 'Take a',
                        secondRow: 'placement',
                        thirdRow: 'test',
                        icon: 'assets/icons/placement_test.png',
                      ),
                      InkWell(
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              Routes.show_teachers,
                            ),
                        child: GlassInkwell(
                          firstRow: 'Show',
                          secondRow: 'LMC',
                          thirdRow: 'teacher',
                          icon: 'assets/icons/private_course.png',
                        ),
                      ),
                      GlassInkwell(
                        firstRow: 'Show',
                        secondRow: 'upcomming',
                        thirdRow: 'courses',
                        icon: 'assets/icons/upcoming_courses.png',
                      ),
                    ],
                  ),
                ),

                // Announcements
                Positioned(
                  top: 470,
                  left: 30,
                  child: Text(
                    "Announcments :",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lmcBlue,
                    ),
                  ),
                ),
                Positioned(
                  top: 500,
                  left: 30,
                  right: 30,
                  child: SizedBox(height: 260, child: AnnouncementsList()),
                ),
              ],
            ),
          ),

          if (isDrawerOpen)
            GestureDetector(
              onTap: toggleDrawer,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: 1.0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            top: 0,
            bottom: 0,
            left: isDrawerOpen ? 0 : -300,
            child: Container(
              width: 300,
              height: double.infinity,
              color: AppColors.backgroundColor,
              child: MyDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}

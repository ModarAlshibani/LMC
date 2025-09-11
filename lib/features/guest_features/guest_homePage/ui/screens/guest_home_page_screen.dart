import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/for_all/announsments/ui/widgets/announcements_list.dart';
import 'package:lmc_app/features/for_all/drawer/ui/my_drawer.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';
import 'package:lmc_app/features/guest_features/drawer/ui/guest_drawer.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/general_text_form_field.dart';
import '../widgets/glass_inkwell.dart';
import '../widgets/top_container.dart';

class GuestHomePageScreen extends StatefulWidget {
  const GuestHomePageScreen({super.key});

  @override
  State<GuestHomePageScreen> createState() => _GuestHomePageScreenState();
}

class _GuestHomePageScreenState extends State<GuestHomePageScreen> {
  bool isDrawerOpen = false;
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = ApiService().getUserName();
  }

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GuestDrawer(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                              onPressed: toggleDrawer,
                              icon: Icon(Icons.menu),
                              iconSize: 30,
                              color: AppColors.backgroundColor,
                            ),
                        
                            FutureBuilder<User>(
                                future: user,
                                builder: (context, userInfo){
                                  if(userInfo.hasData){
                                    return Text("Hi ${userInfo.data!.name}...",
                                      style: TextStyle(
                                          color: AppColors.backgroundColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900),);
                                  } else if(userInfo.hasError){
                                    return Text("${userInfo.error}");
                                  }else{
                                    return const Center(child: CircularProgressIndicator(),);
                                  }
                                }
                            ),
                        horizontalSpace(150.w),
                        Icon(
                          Icons.circle_notifications_outlined,
                          size: 50,
                          color: AppColors.backgroundColor,
                        ),
                      ],
                    ),
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
                      fontSize: 60.sp,
                      color: AppColors.lmcOrange,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
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
            Positioned(
              top: 300.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                width: 360.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            Routes.placement_test_screen,
                          ),
                      child: GlassInkwell(
                        firstRow: 'Take a',
                        secondRow: 'placement',
                        thirdRow: 'test',
                        icon: 'assets/icons/placement_test.png',
                      ),
                    ),
                    InkWell(
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            Routes.private_course,
                          ),
                      child: GlassInkwell(
                        firstRow: 'Ask for a',
                        secondRow: 'private',
                        thirdRow: 'course',
                        icon: 'assets/icons/private_course.png',
                      ),
                    ),
                    InkWell(
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            Routes.available_courses,
                          ),
                      child: GlassInkwell(
                        firstRow: 'Show',
                        secondRow: 'upcomming',
                        thirdRow: 'courses',
                        icon: 'assets/icons/upcoming_courses.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
              child: Container(height: 320, child: AnnouncementsList()),
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
              child: GuestDrawer(),
            ),
          ),
          ],
        ),
      ),
      
    );
    
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/core/helpers/shared_pref_helper.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/guest_homePage/ui/widgets/glass_inkwell.dart';
import 'package:lmc_app/features/guest_homePage/ui/widgets/top_container.dart';
import 'package:lmc_app/features/login/ui/widgets/bottom_blur_container.dart';

class GuestHomePageScreen extends StatelessWidget {
  const GuestHomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text(
                          "Hi User ....",
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.w900,
                          ),
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
                    GlassInkwell(
                      firstRow: 'Take a',
                      secondRow: 'placement',
                      thirdRow: 'test',
                      icon: 'assets/icons/placement_test.png',
                    ),
                    GlassInkwell(
                      firstRow: 'Ask for a',
                      secondRow: 'private',
                      thirdRow: 'course',
                      icon: 'assets/icons/private_course.png',
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
              child: Container(
                height: 320,

                child: ListView.builder(
                  itemCount: 6, // The number of items to display
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color:
                          AppColors.lmcOrange, // Set the color of the container
                      height: 140.0,
                      child: Center(
                        child: FutureBuilder(
                          future: showToken(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: TextStyle(color: Colors.white),
                              );
                            } else {
                              return CircularProgressIndicator(); // or some other loading indicator
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> showToken() async {
  return await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
}

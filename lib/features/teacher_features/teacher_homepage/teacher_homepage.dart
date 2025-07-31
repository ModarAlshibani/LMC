import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/features/for_all/drawer/ui/my_drawer.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/general_text_form_field.dart';
import '../../for_all/announsments/ui/widgets/announcements_list.dart';
import '../../guest_features/guest_homePage/ui/widgets/glass_inkwell.dart';
import '../../guest_features/guest_homePage/ui/widgets/top_container.dart';

class TeacherHomepage extends StatelessWidget {
  const TeacherHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      drawer: MyDrawer(),
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
                        // Menu Button
                        Builder(
                          builder:
                              (context) => GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 15.w),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.menu,
                                    size: 30,
                                    color: AppColors.backgroundColor,
                                  ),
                                ),
                              ),
                        ),
                        Text(
                          "Hi Teacher ....",
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        horizontalSpace(100.w),
                        Icon(
                          Icons.circle_notifications_outlined,
                          size: 50,
                          color: AppColors.backgroundColor,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Thanks for being a part of",
                    style: TextStyle(
                      fontSize: 26.sp,
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
                      firstRow: 'Reserve',
                      secondRow: 'a',
                      thirdRow: 'classroom',
                      icon: 'assets/icons/placement_test.png',
                    ),
                    InkWell(
                      onTap: (){
                        print("navigate to complaints screen");
                      },
                      child: GlassInkwell(
                        firstRow: 'Submit',
                        secondRow: 'a',
                        thirdRow: 'Complaint',
                        icon: 'assets/icons/private_course.png',
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
          ],
        ),
      ),
    );
  }
}

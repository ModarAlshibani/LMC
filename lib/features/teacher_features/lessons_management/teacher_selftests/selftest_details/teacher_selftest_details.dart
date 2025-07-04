import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';
import '../../../../../../core/theming/colors.dart';

class TeacherSelfTestDetails extends StatelessWidget {
  final SelfTests selfTest;
  const TeacherSelfTestDetails({super.key, required this.selfTest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lmcBlue,
      body: Stack(
        children: [
          Positioned(
            top: 30.h,
            left: 20.w,
            child: Text(
              selfTest.title!,
              style: TextStyle(
                color: AppColors.background2,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            top: 85.h,
            bottom: 0.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lightLmcBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "    ${selfTest.description}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            top: 180,
            bottom: -10,
            left: 0.w,
            right: 0.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Positioned(
                left: 20.w,
                right: 20.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Questions: ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          IconButton(
                            highlightColor: AppColors.lmcBlue,
                            onPressed:
                                () => Navigator.pushNamed(
                                  context,
                                  Routes.add_selftest_question,
                                  arguments: selfTest,
                                ),
                            icon: Icon(
                              Icons.add,
                              size: 35,
                              color: AppColors.lmcOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(5),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: GlassContainer(
                        width: double.infinity,
                        height: 480,
                        topLeft: 15,
                        topRight: 15,
                        bottomRight: 15,
                        bottomLeft: 15,
                        withBorder: false,
                        firstColor: AppColors.lmcBlue,
                        secondColor: AppColors.lmcBlue,
                        firstBlurOpacity: 0.1,
                        secondBlurOpacity: 0.2,
                        child: SizedBox.shrink(),
                      ),
                    ),
                    verticalSpace(10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.lmcOrange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_right_alt,
                          size: 60,
                          color: AppColors.lmcBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

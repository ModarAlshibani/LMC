import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_selftest_screen/data/models/selftests_model.dart';

class SelfTestsOutside extends StatelessWidget {
  final SelfTests selfTest;

  const SelfTestsOutside({super.key, required this.selfTest});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print("self test printed"),
      // () => Navigator.pushNamed(context, Routes.teacher_selftests_screen, arguments: course,),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: GlassContainer(
          withBorder: false,
          width: double.infinity,
          height: 140.h,
          topLeft: 10,
          topRight: 10,
          bottomRight: 10,
          bottomLeft: 10,
          firstColor: AppColors.lmcBlue,
          secondColor: AppColors.lmcBlue,
          firstBlurOpacity: 0.3,
          secondBlurOpacity: 0.25,
          sigmaX: 100,
          sigmaY: 100,
          child: Row(
            children: [
              horizontalSpace(10.w),

              horizontalSpace(20.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        selfTest.title!,
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        selfTest.description!,
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(10.w),
            ],
          ),
        ),
      ),
    );
  }
}

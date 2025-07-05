import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/date_time_helper.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';

class SelfTestsOutside extends StatelessWidget {
  final SelfTests selfTest;

  const SelfTestsOutside({super.key, required this.selfTest});

  @override
  Widget build(BuildContext context) {
    final questionCount = selfTest.questions?.length ?? 0;
    final createdDate = DateTimeStringsHelper().formatDate(selfTest.createdAt);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      child: InkWell(
        onTap:
            () => Navigator.pushNamed(
              context,
              Routes.teacher_selftests_details,
              arguments: selfTest,
            ),
        borderRadius: BorderRadius.circular(16.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            // boxShadow: [
            //   BoxShadow(
            //     color: AppColors.background2.withOpacity(1),
            //     blurRadius: 12,
            //     offset: const Offset(0, 1),
            //     spreadRadius: 0,
            //   ),
            // ],
          ),
          child: GlassContainer(
            withBorder: true,
            width: double.infinity,
            height: 160.h,
            topLeft: 16.r,
            topRight: 16.r,
            bottomRight: 16.r,
            bottomLeft: 16.r,
            firstColor: AppColors.lightLmcBlue.withOpacity(0.06),
            secondColor: AppColors.lightLmcBlue.withOpacity(0.05),
            firstBlurOpacity: 0.8,
            secondBlurOpacity: 0.5,
            sigmaX: 80,
            sigmaY: 80,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.lmcBlue.withOpacity(0.8),
                              AppColors.lmcBlue.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lmcBlue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Iconsax.document_text_copy,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),

                      horizontalSpace(16.w),

                      Expanded(
                        child: Text(
                          selfTest.title ?? 'Untitled Test',
                          style: TextStyle(
                            color: AppColors.lmcBlue,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.lmcBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.lmcBlue,
                          size: 16.sp,
                        ),
                      ),
                    ],
                  ),

                  verticalSpace(16.h),

                  // Description
                  Text(
                    selfTest.description ?? 'No description available',
                    style: TextStyle(
                      color: AppColors.lmcBlue.withOpacity(0.7),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lmcBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.help_outline,
                              color: AppColors.lmcBlue,
                              size: 14.sp,
                            ),
                            horizontalSpace(4.w),
                            Text(
                              '$questionCount Questions',
                              style: TextStyle(
                                color: AppColors.lmcBlue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      horizontalSpace(12.w),

                      // Created Date
                      if (createdDate.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lmcOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: AppColors.lmcOrange,
                                size: 12.sp,
                              ),
                              horizontalSpace(4.w),
                              Text(
                                createdDate,
                                style: TextStyle(
                                  color: AppColors.lmcOrange,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                      const Spacer(),

                      // Performance Indicator
                      Container(
                        width: 4.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.lmcBlue.withOpacity(0.8),
                              AppColors.lmcOrange.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

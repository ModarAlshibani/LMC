import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';

class AddFinalTestSection extends StatelessWidget {
  final int courseId;

  const AddFinalTestSection({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: AppColors.lmcOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.quiz_outlined,
                    color: AppColors.lmcOrange,
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "No Final Test Yet",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lmcBlue,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Create the final test to help students practice and assess their knowledge",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.lmcBlue.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.add_final_test_screen,
                    arguments: courseId,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
                    decoration: BoxDecoration(
                      color: AppColors.lmcOrange,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lmcOrange.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Create Final Test",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

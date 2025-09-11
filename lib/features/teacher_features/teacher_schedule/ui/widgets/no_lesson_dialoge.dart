import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class NoLessonsDialog extends StatelessWidget {
  final DateTime selectedDate;

  const NoLessonsDialog({super.key, required this.selectedDate});

  String _formatDate(DateTime date) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return "${date.day} ${months[date.month - 1]}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Section
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lmcOrange.withOpacity(0.2),
                    AppColors.lmcBlue.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                color: AppColors.lmcBlue,
                size: 36.sp,
              ),
            ),

            SizedBox(height: 24.h),

            // Title
            Text(
              "No Lessons Scheduled",
              style: TextStyle(
                color: AppColors.lmcBlue,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12.h),

            // Date
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.lmcOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                _formatDate(selectedDate),
                style: TextStyle(
                  color: AppColors.lmcOrange,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Message
            Text(
              "You don't have any lessons scheduled for this date. Enjoy your free time!",
              style: TextStyle(
                color: AppColors.lmcBlue.withOpacity(0.7),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AppColors.lmcBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Back to Calendar",
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

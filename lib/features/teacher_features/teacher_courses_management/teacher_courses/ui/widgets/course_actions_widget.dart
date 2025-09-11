import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/theming/colors.dart';

class CourseActionsWidget extends StatelessWidget {
  final String? courseId;
  final VoidCallback onLessonsPressed;
  final VoidCallback onFinalExamPressed;
  final VoidCallback onStudentsPressed;
  final VoidCallback onFlashCardsPressed;

  const CourseActionsWidget({
    super.key,
    required this.courseId,
    required this.onLessonsPressed,
    required this.onFinalExamPressed,
    required this.onStudentsPressed,
    required this.onFlashCardsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Course Actions",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.lmcBlue,
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Actions Grid
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.play_lesson_outlined,
                    title: "Lessons",
                    subtitle: "View all lessons",
                    color: AppColors.lmcBlue,
                    onTap: onLessonsPressed,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.quiz_outlined,
                    title: "Final Exam",
                    subtitle: "Manage exam",
                    color: AppColors.lmcOrange,
                    onTap: onFinalExamPressed,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 12.h),
            
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.people_outline,
                    title: "Students",
                    subtitle: "View enrolled students",
                    color: Colors.green,
                    onTap: onStudentsPressed,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.style_outlined,
                    title: "Flash Cards",
                    subtitle: "Course materials",
                    color: Colors.purple,
                    onTap: onFlashCardsPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 28.sp,
                color: color,
              ),
            ),
            
            SizedBox(height: 12.h),
            
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lmcBlue,
              ),
            ),
            
            SizedBox(height: 4.h),
            
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lmcBlue.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
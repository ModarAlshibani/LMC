import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/data/model/my_courses_teacher_model.dart';
import '../../../../../../../core/theming/colors.dart';

class CourseInfoCardWidget extends StatelessWidget {
  final MyCourses course;
  final CourseSchedule courseSchedule;

  const CourseInfoCardWidget({
    super.key,
    required this.course,
    required this.courseSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Course Information",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lmcBlue,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Description
          _buildInfoRow(
            icon: Icons.description_outlined,
            title: "Description",
            content: course.description ?? 'No description added for this course',
          ),
          
          SizedBox(height: 16.h),
          
          // Teacher Name
          _buildInfoRow(
            icon: Icons.person_outline,
            title: "Teacher",
            content: course.teacherName ?? 'No teacher assigned',
          ),
          
          SizedBox(height: 16.h),
          
          // Schedule
          _buildScheduleInfo(),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.lmcBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: AppColors.lmcBlue,
          ),
        ),
        
        SizedBox(width: 12.w),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lmcBlue.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                content,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lmcBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleInfo() {
    List<String> days = courseSchedule.days ?? [];
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.lmcOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            Icons.schedule_outlined,
            size: 20.sp,
            color: AppColors.lmcOrange,
          ),
        ),
        
        SizedBox(width: 12.w),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Schedule",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lmcBlue.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 8.h),
              
              if (days.isNotEmpty)
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: days.map((day) => _buildDayChip(day)).toList(),
                )
              else
                Text(
                  "No schedule added",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lmcBlue.withOpacity(0.6),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayChip(String day) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.lmcOrange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.lmcOrange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.lmcOrange,
        ),
      ),
    );
  }
}
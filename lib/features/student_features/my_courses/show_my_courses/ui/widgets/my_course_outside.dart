import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart';

class MyCourseOutside extends StatelessWidget {
  final MyCoursesStu course;

  const MyCourseOutside({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      child: Material(
        borderRadius: BorderRadius.circular(16.r),
        elevation: 4,
        shadowColor: AppColors.lmcBlue.withOpacity(0.2),
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.lessons_list,
            arguments: course,
          ),
          borderRadius: BorderRadius.circular(16.r),
          child: GlassContainer(
            withBorder: true,
            width: double.infinity,
            height: 180.h,
            topLeft: 16,
            topRight: 16,
            bottomRight: 16,
            bottomLeft: 16,
            firstColor: AppColors.lmcBlue,
            secondColor: AppColors.lmcBlue,
            firstBlurOpacity: 0.15,
            secondBlurOpacity: 0.1,
            sigmaX: 80,
            sigmaY: 80,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Course Image with enhanced styling
                  _buildCourseImage(),
                  horizontalSpace(20.w),
                  // Course Details
                  Expanded(
                    child: _buildCourseDetails(),
                  ),
                  // Status Badge
                  _buildStatusBadge(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseImage() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.lmcBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          course.photo?.replaceAll('localhost', ApiConstants.ip) ?? 
          'assets/images/LMC-LOGO.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.lmcBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.school,
                size: 40.w,
                color: AppColors.lmcBlue,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              decoration: BoxDecoration(
                color: AppColors.lmcBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: AppColors.lmcBlue,
                  strokeWidth: 2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCourseDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Course Title
        Text(
          "${course.language} Course",
          style: TextStyle(
            color: AppColors.lmcBlue,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        verticalSpace(8.h),
        
        // Course Level with icon
        _buildDetailRow(
          icon: Icons.signal_cellular_alt,
          text: "Level ${course.level}",
          fontSize: 13.sp,
        ),
        
        verticalSpace(6.h),
        
        // Teacher with icon
        _buildDetailRow(
          icon: Icons.person_outline,
          text: "Mr ${course.teacherName}",
          fontSize: 13.sp,
        ),
        
        verticalSpace(6.h),
        
        // Hall with icon
        _buildDetailRow(
          icon: Icons.location_on_outlined,
          text: "Room ${course.roomNumber}",
          fontSize: 13.sp,
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String text,
    required double fontSize,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.w,
          color: AppColors.lmcBlue.withOpacity(0.7),
        ),
        horizontalSpace(6.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.lmcBlue.withOpacity(0.8),
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    Color statusColor;
    IconData statusIcon;
    
    switch (course.status?.toLowerCase()) {
      case 'active':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'completed':
        statusColor = Colors.blue;
        statusIcon = Icons.school;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            size: 18.w,
            color: statusColor,
          ),
          verticalSpace(4.h),
          Text(
            course.status ?? 'Unknown',
            style: TextStyle(
              color: statusColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/date_time_helper.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/data/models/my_complaints_model.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/delete_complaint_usecase.dart';

class ComplaintsOutside extends StatelessWidget {
  final Data complaint;

  const ComplaintsOutside({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    final createdDate = DateTimeStringsHelper().formatDate(complaint.createdAt);

    // Get status color and icon based on complaint status
    final statusInfo = _getStatusInfo(complaint.status);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      child: GestureDetector(
        onTap: () => _showComplaintDialog(context),
        child: GlassContainer(
          withBorder: true,
          width: double.infinity,
          height: 170.h,
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
                            AppColors.lmcOrange.withOpacity(0.8),
                            AppColors.lmcOrange.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lmcOrange.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Iconsax.danger_copy,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),

                    horizontalSpace(16.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complaint #${complaint.id?.toString().padLeft(4, '0') ?? '0001'}',
                            style: TextStyle(
                              color: AppColors.lmcBlue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(2.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusInfo['color'].withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  statusInfo['icon'],
                                  color: statusInfo['color'],
                                  size: 12.sp,
                                ),
                                horizontalSpace(4.w),
                                Text(
                                  statusInfo['text'],
                                  style: TextStyle(
                                    color: statusInfo['color'],
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        // Edit button
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.edit_complaint,
                              arguments: {
                                'complaintId': complaint.id.toString(),
                                'subject': complaint.subject.toString(),
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.lmcOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Iconsax.edit_2_copy,
                              color: AppColors.lmcOrange,
                              size: 16.sp,
                            ),
                          ),
                        ),

                        verticalSpace(5.h),

                        GestureDetector(
                          onTap: () => _showDeleteConfirmDialog(context),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Iconsax.trash_copy,
                              color: Colors.red,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                verticalSpace(10.h),

                // Complaint Subject
                Text(
                  complaint.subject ?? 'No subject provided',
                  style: TextStyle(
                    color: AppColors.lmcBlue.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const Spacer(),

                // Bottom Row with Details
                Row(
                  children: [
                    // Category Indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lmcBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.message_question_copy,
                            color: AppColors.lmcBlue,
                            size: 14.sp,
                          ),
                          horizontalSpace(4.w),
                          Text(
                            'Complaint',
                            style: TextStyle(
                              color: AppColors.lmcBlue,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    horizontalSpace(8.w),

                    // Created Date
                    if (createdDate.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lmcOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
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

                    // Status Severity Indicator
                    Container(
                      width: 4.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            statusInfo['color'].withOpacity(0.8),
                            statusInfo['color'].withOpacity(0.4),
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
    );
  }

  // Method to show complaint details dialog
  void _showComplaintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.lmcOrange.withOpacity(0.8),
                            AppColors.lmcOrange.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Iconsax.danger_copy,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    horizontalSpace(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complaint Details',
                            style: TextStyle(
                              color: AppColors.lmcBlue,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'ID: #${complaint.id?.toString().padLeft(4, '0') ?? '0001'}',
                            style: TextStyle(
                              color: AppColors.lmcBlue.withOpacity(0.6),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Close button
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: AppColors.lmcBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.close,
                          color: AppColors.lmcBlue,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                verticalSpace(20.h),

                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusInfo(
                      complaint.status,
                    )['color'].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusInfo(complaint.status)['icon'],
                        color: _getStatusInfo(complaint.status)['color'],
                        size: 16.sp,
                      ),
                      horizontalSpace(6.w),
                      Text(
                        _getStatusInfo(complaint.status)['text'],
                        style: TextStyle(
                          color: _getStatusInfo(complaint.status)['color'],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                verticalSpace(16.h),

                // Subject Label
                Text(
                  'Subject:',
                  style: TextStyle(
                    color: AppColors.lmcBlue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                verticalSpace(8.h),

                // Full Subject Text
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.lightLmcBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.lmcBlue.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    complaint.subject ?? 'No subject provided',
                    style: TextStyle(
                      color: AppColors.lmcBlue.withOpacity(0.8),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),

                verticalSpace(16.h),

                // Created Date
                if (DateTimeStringsHelper()
                    .formatDate(complaint.createdAt)
                    .isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: AppColors.lmcOrange,
                        size: 16.sp,
                      ),
                      horizontalSpace(8.w),
                      Text(
                        'Created: ${DateTimeStringsHelper().formatDate(complaint.createdAt)}',
                        style: TextStyle(
                          color: AppColors.lmcOrange,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to show delete confirmation dialog
  void _showDeleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Warning Icon
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Icon(
                    Iconsax.warning_2_copy,
                    color: Colors.red,
                    size: 32.sp,
                  ),
                ),

                verticalSpace(20.h),

                // Title
                Text(
                  'Delete Complaint',
                  style: TextStyle(
                    color: AppColors.lmcBlue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                verticalSpace(12.h),

                // Message
                Text(
                  'Are you sure you want to delete this complaint? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.lmcBlue.withOpacity(0.7),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),

                verticalSpace(8.h),

                // Complaint ID
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightLmcBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Complaint #${complaint.id?.toString().padLeft(4, '0') ?? '0001'}',
                    style: TextStyle(
                      color: AppColors.lmcBlue,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                verticalSpace(24.h),

                // Action buttons
                Row(
                  children: [
                    // Cancel button
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.lmcBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: AppColors.lmcBlue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    horizontalSpace(12.w),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.red.withOpacity(0.8),
                              Colors.red.withOpacity(0.9),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            DeleteComplaintUseCase(
                              ApiService(),
                            ).execute(complaintId: complaint.id.toString());
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.my_complaints,
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Helper method to get status information
Map<String, dynamic> _getStatusInfo(String? status) {
  switch (status?.toLowerCase()) {
    case 'pending':
      return {
        'color': AppColors.lmcBlue,
        'icon': Icons.pending_actions,
        'text': 'Pending',
      };
    case 'solved':
      return {
        'color': Colors.green,
        'icon': Icons.check_circle,
        'text': 'Solved',
      };
    default:
      return {
        'color': AppColors.lmcOrange,
        'icon': Icons.help_outline,
        'text': 'Pending',
      };
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/data/models/course_student_model.dart';

class StudentAttendanceCard extends StatefulWidget {
  final Students student;
  final Function(int studentId, bool isPresent, double bonusMarks)
  onSendAttendance;

  const StudentAttendanceCard({
    super.key,
    required this.student,
    required this.onSendAttendance,
  });

  @override
  State<StudentAttendanceCard> createState() => _StudentAttendanceCardState();
}

class _StudentAttendanceCardState extends State<StudentAttendanceCard> {
  bool isPresent = false;
  final TextEditingController bonusController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    bonusController.dispose();
    super.dispose();
  }

  void _handleSendAttendance() async {
    setState(() {
      isLoading = true;
    });

    double bonusMarks = double.tryParse(bonusController.text) ?? 0.0;

    await widget.onSendAttendance(
      widget.student.id ?? 0,
      isPresent,
      bonusMarks,
    );

    setState(() {
      isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance marked for ${widget.student.name}'),
          backgroundColor: AppColors.lmcBlue,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
        child: GlassContainer(
          withBorder: true,
          width: double.infinity,
          height: 150.h,
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.student.name ?? 'Unknown Student',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lmcBlue,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(4),
                          Text(
                            'ID: ${widget.student.id ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lmcBlue.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Attendance Checkbox
                    Row(
                      children: [
                        Text(
                          'Present',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lmcBlue,
                          ),
                        ),
                        horizontalSpace(8),
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: isPresent,
                            onChanged: (value) {
                              setState(() {
                                isPresent = value ?? false;
                              });
                            },
                            activeColor: AppColors.lmcBlue,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(16),
                // Bonus Marks Row
                Row(
                  children: [
                    // Bonus TextField
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.lightLmcBlue.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          controller: bonusController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.lmcBlue,
                            
                          ),
                          decoration: InputDecoration(
                            hintText: 'Bonus marks',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.lmcBlue.withOpacity(0.5),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Iconsax.award,
                              size: 18.sp,
                              color: AppColors.lmcBlue.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(12),
                    // Send Button
                    SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleSendAttendance,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lmcBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          elevation: 0,
                        ),
                        child:
                            isLoading
                                ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Row(
                                  children: [
                                    Icon(Iconsax.send_1, size: 18.sp),
                                    horizontalSpace(6),
                                    Text(
                                      'Send',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/App_button.dart';
import 'package:lmc_app/core/widgets/adabtive_text_field.dart';
import 'package:lmc_app/core/widgets/custom_app_bar.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/send_task_to_sec/logic/cubit/send_task_to_sec_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart';

class SendTaskToSecScreen extends StatelessWidget {
  TeacherLessons lesson;
  TextEditingController descriptionController = TextEditingController();

  SendTaskToSecScreen({Key? key, required this.lesson}) : super(key: key);

  void sendTaskToSec(BuildContext context) {
    final description = descriptionController.text.trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task description can't be empty!")),
      );
      return;
    }

    context.read<SendTaskToSecCubit>().sendTaskToSecState(
      description: description,
      deadline: DateTime.parse(lesson.date!),
      lessonId: lesson.id!,
      courseId: lesson.courseId!,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Send Task"),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                    // Lesson info section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.lmcBlue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.lmcBlue.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lesson Information",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lmcBlue.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            lesson.title ?? "Lesson's id is: ${lesson.id}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      "Task Description",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    AdabtiveTextField(
                      controller: descriptionController,
                      labelText: "Enter task description for students",
                      maxHeight: 200.h,
                      fillColor: AppColors.backgroundColor,
                      labelTextStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lmcBlue.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                      inputTextStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lmcBlue,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(
                        Iconsax.message_question,
                        color: AppColors.lmcBlue.withOpacity(0.7),
                        size: 24.sp,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lmcBlue.withOpacity(0.2),
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lmcOrange.withOpacity(0.8),
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),

                    Spacer(),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lmcOrange,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lmcOrange.withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () => sendTaskToSec(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          "Send Task",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

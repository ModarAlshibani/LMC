// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  Lessons lesson;
  TextEditingController descriptionController = TextEditingController();
  SendTaskToSecScreen({Key? key, required this.lesson}) : super(key: key);

  void sendTaskToSec(BuildContext context) {
    final description = descriptionController.text.trim();

    if (description == null) {
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
      body: Column(
        children: [
          CustomAppBar(title: "Send Task"),
          Text(lesson.title ?? "Lesson's id is: ${lesson.id}"),
          AdabtiveTextField(
            labelText: "Task Description",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBorder, width: 1.4),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lmcOrange, width: 1.4),
              borderRadius: BorderRadius.circular(20.0),
            ),
            inputTextStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.lmcBlue,
            ),
            prefixIcon: Icon(
              Iconsax.message_question,
              color: AppColors.lmcBlue,
              size: 30.sp,
            ),
            controller: descriptionController,
          ),

          AppTextButton(
            buttonText: "Send Task",
            textStyle: TextStyle(fontSize: 16, color: AppColors.background2),
            onPressed: () => sendTaskToSec(context),
            backgroundColor: AppColors.lmcBlue,
          ),
        ],
      ),
    );
  }
}

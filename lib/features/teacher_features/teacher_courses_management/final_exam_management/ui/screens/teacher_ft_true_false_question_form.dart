import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/App_button.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/add_question_header.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/media_upload_section.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/question_text_widget.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/true_flase_selector.dart';
import 'dart:io';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/add_final_test_question_cubit.dart';

class TrueFalseQuestionFormFT extends StatefulWidget {
  final int testId;
  TrueFalseQuestionFormFT({Key? key, required this.testId}) : super(key: key);

  @override
  State<TrueFalseQuestionFormFT> createState() => _TrueFalseQuestionFormFTState();
}

class _TrueFalseQuestionFormFTState extends State<TrueFalseQuestionFormFT> {
  final TextEditingController _questionTextController = TextEditingController();
  
  final TextEditingController _markTextController = TextEditingController();
  List<String>? choices;
  String? correctAnswer;
  File? _media;

  void _addFinalTestQuestion(BuildContext context) {
    final questionText = _questionTextController.text;
    final mark = double.tryParse(_markTextController.text);
    if (questionText.isEmpty || correctAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("⚠️ Question text and correct answer are required!"),
          backgroundColor: Color.fromARGB(255, 225, 70, 95),
        ),
      );
      return;
    }

    context.read<AddFinalTestQuestionCubit>().AddFinalTestQuestion(
      testId: widget.testId,
      media: _media,
      questionText: questionText,
      type: "true_false",
      choices: choices,
      correctAnswer: correctAnswer ?? "true",
      point: mark ?? 5,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFinalTestQuestionCubit, AddFinalTestQuestionState>(
      listener: (context, state) {
        if (state is AddFinalTestQuestionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("🎉 Question added successfully!"),
              backgroundColor: AppColors.lmcOrange,
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AddFinalTestQuestionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("❌ Failed to add question. Please try again!"),
              backgroundColor: Color.fromARGB(255, 225, 70, 95),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background2,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                AddQuestionHeader(
                  color: AppColors.green,
                  title: "True/False Question",
                  description: "Create a statement-based question",
                  icon: Iconsax.shield_tick,
                ),
                verticalSpace(10.h),

                // Media Upload Section
                MediaPickerSection(
                  title: "Supporting Media",
                  subtitle:
                      "Add images or videos to support your statement (optional)",
                  icon: Iconsax.gallery,
                  iconColor: AppColors.lmcOrange,
                  onMediaSelected: (platformFile) {
                    if (platformFile.path != null) {
                      final pickedFile = File(platformFile.path!);
                      setState(() {
                        _media = pickedFile;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "⚠️ Cannot use this media on this platform.",
                          ),
                          backgroundColor: Color.fromARGB(255, 225, 70, 95),
                        ),
                      );
                    }
                  },
                ),

                verticalSpace(10.h),

                // Statement Section
                QuestionTextWidget(
                  textEditingController: _questionTextController,
                  labelText: "Enter your statement ...",
                  header: "Statement",
                  description:
                      "Write a clear statement that can be true or false.",
                  icon: Iconsax.document_text,
                ),

                verticalSpace(10.h),

                QuestionTextWidget(
                  textEditingController: _markTextController,
                  labelText: "mark",
                  header: "Question Mark",
                  description:
                      "How many marks you want to add for this question?",
                  icon: Iconsax.document_text,
                ),

                verticalSpace(10.h),

                // True/False Selector Section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: AppColors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Iconsax.tick_square,
                                color: AppColors.green,
                                size: 20.sp,
                              ),
                            ),
                            horizontalSpace(12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Correct Answer",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.lmcBlue,
                                    ),
                                  ),
                                  Text(
                                    "Choose whether the statement is true or false",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lmcBlue.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(24.h),
                        TrueFalseSelector(
                          selectedAnswer: correctAnswer,
                          onSelected: (val) {
                            setState(() {
                              correctAnswer = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                verticalSpace(10.h),

                // Submit Button Section
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child:
                      state is AddFinalTestQuestionLoading
                          ? Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: CircularProgressIndicator(
                                    color: AppColors.lmcOrange,
                                    strokeWidth: 2.5,
                                  ),
                                ),
                                horizontalSpace(12.w),
                                Text(
                                  "Adding Question...",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lmcBlue.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : AppTextButton(
                            buttonText: "Add True/False Question",
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            onPressed: () => _addFinalTestQuestion(context),
                            backgroundColor: AppColors.lmcBlue,
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

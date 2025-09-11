import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/App_button.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/core/widgets/adabtive_text_field.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/add_question_header.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/question_text_widget.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/add_final_test_question_cubit.dart';

class TranslationQuestionFormFT extends StatefulWidget {
  final int testId;
  const TranslationQuestionFormFT({Key? key, required this.testId})
    : super(key: key);

  @override
  State<TranslationQuestionFormFT> createState() =>
      _TranslationQuestionFormFTState();
}

class _TranslationQuestionFormFTState extends State<TranslationQuestionFormFT> {
  final TextEditingController _questionTextController = TextEditingController();
  final TextEditingController _markTextController = TextEditingController();
  final TextEditingController _correctAnswerController =
      TextEditingController();

  void _addFinalTestQuestion(BuildContext context) {
    final questionText = _questionTextController.text.trim();
    final correctAnswer = _correctAnswerController.text.trim();
final mark = double.tryParse(_markTextController.text);
// mark will be null if parsing fails
    if (questionText.isEmpty || correctAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("⚠️ Question and answer must not be empty!"),
          backgroundColor: Color.fromARGB(255, 225, 70, 95),
        ),
      );
      return;
    }

    context.read<AddFinalTestQuestionCubit>().AddFinalTestQuestion(
      testId: widget.testId,
      questionText: questionText,
      type: "translate",
      correctAnswer: correctAnswer,
      context: context, point: mark ?? 5,
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
              content: Text("❌ Failed to add question. Please try again."),
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
                // Header Section with Icon and Title
                AddQuestionHeader(
                  color: AppColors.lmcOrange,
                  title: "Translation Question",
                  description: "Create a sentence translation challenge", icon: Iconsax.translate,
                ),
                verticalSpace(15.h),

                QuestionTextWidget(
                  textEditingController: _questionTextController,
                  labelText: "Enter your sentence ...",
                  header: "Original Sentence",
                  description: "Enter the sentence to be translated",
                  icon: Iconsax.document_text,
                ),

                verticalSpace(10.h),

                QuestionTextWidget(
                  textEditingController: _correctAnswerController,
                  labelText: "Enter the correct translation ...",
                  header: "Correct Translation",
                  description: "Provide the accurate translation",
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

                verticalSpace(5.h),

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
                            buttonText: "Submit Translation Question",
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

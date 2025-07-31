import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/App_button.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/logic/cubit/add_selftest_question_cubit.dart';
import 'package:lmc_app/core/widgets/adabtive_text_field.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';

class TranslationQuestionForm extends StatefulWidget {
  final SelfTests selfTest;
  const TranslationQuestionForm({Key? key, required this.selfTest})
    : super(key: key);

  @override
  State<TranslationQuestionForm> createState() =>
      _TranslationQuestionFormState();
}

class _TranslationQuestionFormState extends State<TranslationQuestionForm> {
  final TextEditingController _questionTextController = TextEditingController();
  final TextEditingController _correctAnswerController =
      TextEditingController();

  void _addSelfTestQuestion(BuildContext context) {
    final questionText = _questionTextController.text.trim();
    final correctAnswer = _correctAnswerController.text.trim();

    if (questionText.isEmpty || correctAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("⚠️ Question and answer must not be empty!"),
          backgroundColor: Color.fromARGB(255, 225, 70, 95),
        ),
      );
      return;
    }

    context.read<AddSelfTestQuestionCubit>().AddSelfTestQuestion(
      selfTestId: widget.selfTest.id!,
     
      questionText: questionText,
      type: "translate",
      
      correctAnswer: correctAnswer,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSelfTestQuestionCubit, AddSelfTestQuestionState>(
      listener: (context, state) {
        if (state is AddSelfTestQuestionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("🎉 Question added successfully!"),
              backgroundColor: AppColors.lmcOrange,
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AddSelfTestQuestionFailure) {
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
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: AppColors.background2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 900),
              curve: Curves.easeOutExpo,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child!,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.translate,
                    size: 60.sp,
                    color: AppColors.lmcOrange.withOpacity(0.8),
                  ),
                  verticalSpace(10.h),
                  Text(
                    "Add Translation Question",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lmcBlue,
                    ),
                  ),
                  verticalSpace(20.h),

                  // Original Sentence Field
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lmcBlue.withOpacity(0.08),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: AdabtiveTextField(
                      labelText: "Original Sentence",
                      controller: _questionTextController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.greyBorder,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lmcOrange,
                          width: 1.4,
                        ),
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
                    ),
                  ),

                  verticalSpace(20.h),

                  // Correct Answer Field
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lmcBlue.withOpacity(0.08),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: AdabtiveTextField(
                      labelText: "Correct Translation",
                      controller: _correctAnswerController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.greyBorder,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lmcOrange,
                          width: 1.4,
                        ),
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
                    ),
                  ),

                  verticalSpace(30.h),

                  // Button or Loader
                  state is AddSelfTestQuestionLoading
                      ? CircularProgressIndicator(color: AppColors.lmcOrange)
                      : AppTextButton(
                        buttonText: "Submit Translation",
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.background2,
                        ),
                        onPressed: () => _addSelfTestQuestion(context),
                        backgroundColor: AppColors.lmcBlue,
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

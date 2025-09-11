import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/App_button.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/logic/cubit/add_selftest_question_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/add_question_header.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/choice_widget.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/media_upload_section.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/question_text_widget.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';


class McqQuestionForm extends StatefulWidget {
  final SelfTests selfTest;
  McqQuestionForm({Key? key, required this.selfTest}) : super(key: key);

  @override
  State<McqQuestionForm> createState() => _McqQuestionFormState();
}

class _McqQuestionFormState extends State<McqQuestionForm> {
  final TextEditingController _questionTextController = TextEditingController();
  final TextEditingController _choiceAController = TextEditingController();
  final TextEditingController _choiceBController = TextEditingController();
  final TextEditingController _choiceCController = TextEditingController();
  final TextEditingController _choiceDController = TextEditingController();
  String? correctAnswer;
  File? _media;

  void _addSelfTestQuestion(BuildContext context) {
    final questionText = _questionTextController.text;
    final List<String> choices = [
      _choiceAController.text,
      _choiceBController.text,
      _choiceCController.text,
      _choiceDController.text,
    ];

    if (questionText.isEmpty ||
        correctAnswer == null ||
        choices.any((choice) => choice.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "⚠️ Question text, all choices, and correct answer are required!",
          ),
          backgroundColor: Color.fromARGB(255, 225, 70, 95),
        ),
      );
      return;
    }

    context.read<AddSelfTestQuestionCubit>().AddSelfTestQuestion(
      selfTestId: widget.selfTest.id!,
      media: _media,
      questionText: questionText,
      type: "MCQ",
      choices: choices,
      correctAnswer: correctAnswer!,
      context: context,
    );
  }

  void handleSelection(bool selected, TextEditingController controller) {
    if (selected) {
      setState(() {
        correctAnswer = controller.text;
      });
    }
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
                  color: AppColors.lightLmcBlue,
                  title: "Multiple Choice Question",
                  description: "Create a question with multiple options",
                  icon: Iconsax.message_question,
                ),
                verticalSpace(10.h),

                // Media Upload Section
                MediaPickerSection(
                  title: "Supporting Media",
                  subtitle:
                      "Add images or videos to support your question (optional)",
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

                // Question Text Section
                QuestionTextWidget(
                  textEditingController: _questionTextController,
                  labelText: "Enter your question ...",
                  header: "Question Text",
                  description: "Write a clear and concise question",
                  icon: Iconsax.document_text,
                ),

                verticalSpace(10.h),

                // Answer Choices Section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                Iconsax.clipboard_text,
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
                                    "Answer Choices",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.lmcBlue,
                                    ),
                                  ),
                                  Text(
                                    "Provide four options and select the correct answer",
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
                        verticalSpace(16.h),
                        ChoiceWidget(
                          label: 'Choice A',
                          controller: _choiceAController,
                          onSelected:
                              (val) => handleSelection(val, _choiceAController),
                        ),
                        verticalSpace(12.h),
                        ChoiceWidget(
                          label: 'Choice B',
                          controller: _choiceBController,
                          onSelected:
                              (val) => handleSelection(val, _choiceBController),
                        ),
                        verticalSpace(12.h),
                        ChoiceWidget(
                          label: 'Choice C',
                          controller: _choiceCController,
                          onSelected:
                              (val) => handleSelection(val, _choiceCController),
                        ),
                        verticalSpace(12.h),
                        ChoiceWidget(
                          label: 'Choice D',
                          controller: _choiceDController,
                          onSelected:
                              (val) => handleSelection(val, _choiceDController),
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
                      state is AddSelfTestQuestionLoading
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
                            buttonText: "Add Multiple Choice Question",
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            onPressed: () => _addSelfTestQuestion(context),
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

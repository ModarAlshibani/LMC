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
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/choice_widget.dart';
import 'package:lmc_app/core/widgets/upload_media.dart';
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
    if (questionText == null || correctAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Question text and Correct answer can't be empty!"),
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
      correctAnswer: correctAnswer ?? " ",
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
              content: Text("question added successfully"),
              backgroundColor: AppColors.lmcOrange,
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AddSelfTestQuestionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Faild adding question, try again!")),
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
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UploadMedia(
                      onMediaSelected: (platformFile) {
                        if (platformFile.path != null) {
                          final pickedFile = File(platformFile.path!);
                          print(pickedFile.path);
                          setState(() {
                            _media = pickedFile;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "⚠️ Cannot use this media on this platform.",
                              ),
                            ),
                          );
                        }
                      },
                    ),

                    verticalSpace(20.h),
                    AdabtiveTextField(
                      labelText: "Question text",
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
                      controller: _questionTextController,
                    ),
                    verticalSpace(20.h),
                    ChoiceWidget(
                      label: 'Choice A',
                      controller: _choiceAController,
                      onSelected:
                          (val) => handleSelection(val, _choiceAController),
                    ),
                    verticalSpace(10.h),
                    ChoiceWidget(
                      label: 'Choice B',
                      controller: _choiceBController,
                      onSelected:
                          (val) => handleSelection(val, _choiceAController),
                    ),
                    verticalSpace(10.h),
                    ChoiceWidget(
                      label: 'Choice C',
                      controller: _choiceCController,
                      onSelected:
                          (val) => handleSelection(val, _choiceAController),
                    ),
                    verticalSpace(10.h),
                    ChoiceWidget(
                      label: 'Choice D',
                      controller: _choiceDController,
                      onSelected:
                          (val) => handleSelection(val, _choiceAController),
                    ),

                    verticalSpace(20.h),
                    if (state is AddSelfTestQuestionLoading)
                      CircularProgressIndicator()
                    else
                      AppTextButton(
                        buttonText: "Add Question",
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.background2,
                        ),
                        onPressed: () => _addSelfTestQuestion(context),
                        backgroundColor: AppColors.lmcBlue,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void handleSelection(bool selected, TextEditingController controller) {
    if (selected) {
      setState(() {
        correctAnswer = controller.text;
      });
    }
  }
}

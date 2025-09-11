import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/di/dependency_injection.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/get_all_final_test_questions_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/get_all_final_test_questions_state.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/submit_final_test_answer_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/all_final_test_questions_model.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/submit_final_test_result_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/ui/screens/final_test_resault_screen.dart';

class FinalTestQuestionsScreen extends StatefulWidget {
  final int testId;

  const FinalTestQuestionsScreen({super.key, required this.testId});

  @override
  State<FinalTestQuestionsScreen> createState() =>
      _FinalTestQuestionsScreenState();
}

class _FinalTestQuestionsScreenState extends State<FinalTestQuestionsScreen> {
  int currentQuestionIndex = 0;
  Map<int, dynamic> userAnswers = {};
  int totalPoints = 0;
  bool testSubmitted = false;

  @override
  void initState() {
    super.initState();
    context.read<GetAllFinalTestQuestionsCubit>().fetchGetAllFinalTestQuestions(
      widget.testId,
    );
  }

  void _submitAnswer(Questions question, dynamic answer) {
    setState(() {
      userAnswers[question.id!] = answer;
    });
  }

  Future<void> _nextQuestion(List<Questions> questions) async {
    final currentQuestion = questions[currentQuestionIndex];
    String answerToSubmit = _getCurrentAnswer(currentQuestion);
    await _submitCurrentAnswer(currentQuestion, answerToSubmit);

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  String _getCurrentAnswer(Questions question) {
    final currentAnswer = userAnswers[question.id];

    if (currentAnswer == null) {
      return "wrong answer";
    }

    switch (question.type?.toLowerCase()) {
      case 'mcq':
        return currentAnswer.toString();
      case 'translate':
        String answer = currentAnswer.toString().trim();
        return answer.isEmpty ? "wrong answer" : answer;
      case 'true_false':
        return currentAnswer.toString();
      default:
        String answer = currentAnswer.toString().trim();
        return answer.isEmpty ? "wrong answer" : answer;
    }
  }

  Future<void> _submitCurrentAnswer(Questions question, String answer) async {
    try {
      final submitCubit = context.read<SubmitFinalTestAnswerCubit?>();
      if (submitCubit != null) {
        await submitCubit.SubmitFinalTestAnswer(
          testId: widget.testId.toString(),
          questionId: question.id.toString(),
          answer: answer,
          context: context,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit answer: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: BlocConsumer<
          GetAllFinalTestQuestionsCubit,
          GetAllFinalTestQuestionsState
        >(
          listener: (context, state) {
            if (state is GetAllFinalTestQuestionsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(context),
                Expanded(child: _buildBody(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: AppColors.lmcBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.lmcBlue,
                size: 16.sp,
              ),
            ),
          ),
          horizontalSpace(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Final Test",
                  style: TextStyle(
                    color: AppColors.lmcBlue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Complete all questions",
                  style: TextStyle(
                    color: AppColors.lmcBlue.withOpacity(0.6),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, GetAllFinalTestQuestionsState state) {
    if (state is GetAllFinalTestQuestionsLoading) {
      return _buildLoadingWidget();
    } else if (state is GetAllFinalTestQuestionsFailure) {
      return _buildErrorWidget(context, state.error);
    } else if (state is GetAllFinalTestQuestionsSuccess) {
      final questions = state.finalTestQuestions;

      if (questions.isEmpty) {
        return _buildEmptyWidget();
      }

      if (testSubmitted) {
        return _buildTestCompletedView(questions);
      }

      return _buildQuestionWidget(context, questions);
    }
    return Container();
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Container(
        width: 200.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.lmcBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.lmcBlue),
                strokeWidth: 2.5,
              ),
            ),
            verticalSpace(12.h),
            Text(
              'Loading questions...',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lmcBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.red.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.warning_2, size: 40.sp, color: Colors.red),
            verticalSpace(16.h),
            Text(
              'Error Loading Questions',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            verticalSpace(8.h),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.red.withOpacity(0.7),
              ),
            ),
            verticalSpace(20.h),
            SizedBox(
              width: 120.w,
              height: 36.h,
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<GetAllFinalTestQuestionsCubit>()
                      .fetchGetAllFinalTestQuestions(widget.testId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.lmcBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.document_text,
              size: 40.sp,
              color: AppColors.lmcBlue.withOpacity(0.5),
            ),
            verticalSpace(16.h),
            Text(
              'No Questions Available',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lmcBlue,
              ),
            ),
            verticalSpace(8.h),
            Text(
              'There are no questions available for this test.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.lmcBlue.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(BuildContext context, List<Questions> questions) {
    final currentQuestion = questions[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == questions.length - 1;

    return Column(
      children: [
        // Progress and Question Info
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getQuestionTypeColor(
                    currentQuestion.type,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getQuestionTypeIcon(currentQuestion.type),
                      color: _getQuestionTypeColor(currentQuestion.type),
                      size: 14.sp,
                    ),
                    horizontalSpace(6.w),
                    Text(
                      'Q${currentQuestionIndex + 1}/${questions.length}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: _getQuestionTypeColor(currentQuestion.type),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.lmcOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.star, color: AppColors.lmcOrange, size: 12.sp),
                    horizontalSpace(4.w),
                    Text(
                      '${currentQuestion.point ?? 0} pts',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lmcOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        verticalSpace(16.h),

        // Progress Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: AppColors.lmcBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (currentQuestionIndex + 1) / questions.length,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lmcBlue,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
        ),

        verticalSpace(24.h),

        // Question Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: _buildQuestionContent(currentQuestion),
          ),
        ),

        // Navigation Controls
        Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              if (isLastQuestion) ...[
                // Submit Test Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _nextQuestion(questions);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lmcOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.send_1, size: 16.sp),
                        horizontalSpace(8.w),
                        Text(
                          'Submit Test',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(12.h),
                // View Results Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<SubmitFinalTestResultCubit>(
                                      create:
                                          (context) =>
                                              getIt<
                                                SubmitFinalTestResultCubit
                                              >(),
                                    ),
                                  ],
                                  child: FinalTestResultScreen(
                                    testId: widget.testId,
                                  ),
                                ),
                          ),
                        ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lmcBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.chart_success, size: 16.sp),
                        horizontalSpace(8.w),
                        Text(
                          'View Results',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _nextQuestion(questions);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lmcOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next Question',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        horizontalSpace(8.w),
                        Icon(Iconsax.arrow_right_3, size: 16.sp),
                      ],
                    ),
                  ),
                ),
              ],

              if (currentQuestionIndex > 0) ...[verticalSpace(12.h)],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionContent(Questions question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question Type Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: _getQuestionTypeColor(question.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: _getQuestionTypeColor(question.type).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getQuestionTypeIcon(question.type),
                color: _getQuestionTypeColor(question.type),
                size: 14.sp,
              ),
              horizontalSpace(6.w),
              Text(
                _getQuestionTypeLabel(question.type),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: _getQuestionTypeColor(question.type),
                ),
              ),
            ],
          ),
        ),

        verticalSpace(16.h),

        // Media Section
        if (question.media != null && question.media!.isNotEmpty) ...[
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.lmcBlue.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                question.media!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.backgroundColor.withOpacity(0.5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.image,
                            size: 32.sp,
                            color: AppColors.lmcBlue.withOpacity(0.5),
                          ),
                          verticalSpace(8.h),
                          Text(
                            'Image not available',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.lmcBlue.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          verticalSpace(16.h),
        ],

        // Question Text Section
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.lmcOrange.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.lmcOrange.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.message_question,
                    size: 16.sp,
                    color: AppColors.lmcOrange,
                  ),
                  horizontalSpace(8.w),
                  Text(
                    'Question',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lmcOrange,
                    ),
                  ),
                ],
              ),
              verticalSpace(12.h),
              Text(
                question.questionText ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lmcBlue,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        verticalSpace(20.h),

        // Answer Section
        Text(
          'Select your answer:',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lmcBlue.withOpacity(0.7),
          ),
        ),

        verticalSpace(12.h),

        // Question Input
        _buildQuestionInput(question),
      ],
    );
  }

  Widget _buildQuestionInput(Questions question) {
    switch (question.type?.toLowerCase()) {
      case 'mcq':
        return _buildMCQInput(question);
      case 'translate':
        return _buildTranslateInput(question);
      case 'true_false':
        return _buildTrueFalseInput(question);
      default:
        return _buildDefaultInput(question);
    }
  }

  Widget _buildMCQInput(Questions question) {
    if (question.choices == null) return const SizedBox.shrink();

    List<String> choices = [];
    try {
      choices = List<String>.from(jsonDecode(question.choices!));
    } catch (e) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'Error loading choices',
          style: TextStyle(color: Colors.red, fontSize: 13.sp),
        ),
      );
    }

    return Column(
      children:
          choices.asMap().entries.map((entry) {
            final index = entry.key;
            final choice = entry.value;
            final isSelected = userAnswers[question.id] == choice;
            final optionLetter = String.fromCharCode(
              65 + index,
            ); // A, B, C, D...

            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () => _submitAnswer(question, choice),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? AppColors.lmcOrange.withOpacity(0.08)
                            : AppColors.backgroundColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color:
                          isSelected
                              ? AppColors.lmcOrange.withOpacity(0.3)
                              : AppColors.lmcBlue.withOpacity(0.1),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.lmcOrange
                                  : AppColors.lmcBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child:
                              isSelected
                                  ? Icon(
                                    Iconsax.tick_circle,
                                    size: 14.sp,
                                    color: Colors.white,
                                  )
                                  : Text(
                                    optionLetter,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.lmcBlue,
                                    ),
                                  ),
                        ),
                      ),
                      horizontalSpace(12.w),
                      Expanded(
                        child: Text(
                          choice,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                isSelected
                                    ? AppColors.lmcOrange
                                    : AppColors.lmcBlue.withOpacity(0.8),
                            height: 1.3,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Iconsax.tick_square,
                          size: 14.sp,
                          color: AppColors.lmcOrange,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildTranslateInput(Questions question) {
    final controller = TextEditingController();
    if (userAnswers[question.id] != null) {
      controller.text = userAnswers[question.id];
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lmcBlue.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.language_square,
                size: 16.sp,
                color: AppColors.lmcBlue,
              ),
              horizontalSpace(8.w),
              Text(
                'Translation',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lmcBlue,
                ),
              ),
            ],
          ),
          verticalSpace(12.h),
          TextField(
            controller: controller,
            onChanged: (value) => _submitAnswer(question, value),
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter your translation...',
              hintStyle: TextStyle(
                color: AppColors.lmcBlue.withOpacity(0.5),
                fontSize: 13.sp,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.lmcBlue.withOpacity(0.2),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.lmcOrange, width: 1.5),
              ),
            ),
            style: TextStyle(fontSize: 13.sp, color: AppColors.lmcBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildTrueFalseInput(Questions question) {
    final selectedAnswer = userAnswers[question.id];

    return Column(
      children: [
        Text(
          'Select True or False:',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lmcBlue.withOpacity(0.7),
          ),
        ),
        verticalSpace(16.h),
        Row(
          children: [
            Expanded(
              child: _buildTrueFalseOption(
                question: question,
                value: true,
                label: 'True',
                isSelected: selectedAnswer == true,
                color: Colors.green,
                icon: Iconsax.tick_circle,
              ),
            ),
            horizontalSpace(16.w),
            Expanded(
              child: _buildTrueFalseOption(
                question: question,
                value: false,
                label: 'False',
                isSelected: selectedAnswer == false,
                color: Colors.red,
                icon: Iconsax.close_circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrueFalseOption({
    required Questions question,
    required bool value,
    required String label,
    required bool isSelected,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => _submitAnswer(question, value),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? color.withOpacity(0.08)
                  : AppColors.backgroundColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isSelected
                    ? color.withOpacity(0.3)
                    : AppColors.lmcBlue.withOpacity(0.1),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: isSelected ? color : color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: isSelected ? Colors.white : color,
              ),
            ),
            verticalSpace(12.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? color : AppColors.lmcBlue.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultInput(Questions question) {
    final controller = TextEditingController();
    if (userAnswers[question.id] != null) {
      controller.text = userAnswers[question.id];
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lmcBlue.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.edit_2, size: 16.sp, color: AppColors.lmcBlue),
              horizontalSpace(8.w),
              Text(
                'Your Answer',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lmcBlue,
                ),
              ),
            ],
          ),
          verticalSpace(12.h),
          TextField(
            controller: controller,
            onChanged: (value) => _submitAnswer(question, value),
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter your answer...',
              hintStyle: TextStyle(
                color: AppColors.lmcBlue.withOpacity(0.5),
                fontSize: 13.sp,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.lmcBlue.withOpacity(0.2),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.lmcOrange, width: 1.5),
              ),
            ),
            style: TextStyle(fontSize: 13.sp, color: AppColors.lmcBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCompletedView(List<Questions> questions) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          verticalSpace(40.h),

          // Success Icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.tick_circle, size: 40.sp, color: Colors.green),
          ),

          verticalSpace(24.h),

          // Completion Message
          Text(
            'Test Completed!',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lmcBlue,
            ),
          ),

          verticalSpace(8.h),

          Text(
            'You have successfully submitted all your answers',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.lmcBlue.withOpacity(0.6),
            ),
          ),

          verticalSpace(32.h),

          // Summary Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.lmcBlue.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.chart_success,
                      color: AppColors.lmcBlue,
                      size: 18.sp,
                    ),
                    horizontalSpace(8.w),
                    Text(
                      'Test Summary',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                  ],
                ),
                verticalSpace(16.h),
                _buildSummaryRow(
                  'Total Questions',
                  questions.length.toString(),
                  Iconsax.document_text,
                ),
                _buildSummaryRow(
                  'Answered Questions',
                  userAnswers.length.toString(),
                  Iconsax.tick_circle,
                ),
                _buildSummaryRow(
                  'Unanswered Questions',
                  (questions.length - userAnswers.length).toString(),
                  Iconsax.close_circle,
                ),
              ],
            ),
          ),

          verticalSpace(32.h),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lmcOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.home, size: 16.sp),
                  horizontalSpace(8.w),
                  Text(
                    'Return to Home',
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
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: AppColors.lmcBlue.withOpacity(0.7)),
          horizontalSpace(12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.lmcBlue.withOpacity(0.8),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.lmcBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lmcBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getQuestionTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'mcq':
        return Colors.blue;
      case 'translate':
        return Colors.purple;
      case 'true_false':
        return AppColors.lmcOrange;
      default:
        return AppColors.lmcBlue;
    }
  }

  IconData _getQuestionTypeIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'mcq':
        return Iconsax.menu_board;
      case 'translate':
        return Iconsax.language_square;
      case 'true_false':
        return Iconsax.toggle_on_circle;
      default:
        return Iconsax.message_question;
    }
  }

  String _getQuestionTypeLabel(String? type) {
    switch (type?.toLowerCase()) {
      case 'mcq':
        return 'Multiple Choice';
      case 'translate':
        return 'Translation';
      case 'true_false':
        return 'True/False';
      default:
        return 'Question';
    }
  }
}

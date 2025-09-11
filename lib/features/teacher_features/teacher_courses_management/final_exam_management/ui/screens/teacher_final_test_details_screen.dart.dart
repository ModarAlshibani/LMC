import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/teacher_final_test_questions_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/get_final_test_questions_cubit.dart';

class TeacherFinalTestDetailsScreen extends StatefulWidget {
  final int testId;

  const TeacherFinalTestDetailsScreen({super.key, required this.testId});

  @override
  State<TeacherFinalTestDetailsScreen> createState() =>
      _TeacherFinalTestDetailsScreenState();
}

class _TeacherFinalTestDetailsScreenState
    extends State<TeacherFinalTestDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetTeacherFinalTestQuestionsCubit>().fetchFinalTestQuestions(
      widget.testId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<
                GetTeacherFinalTestQuestionsCubit,
                GetTeacherFinalTestQuestionsState
              >(
                builder: (context, state) {
                  if (state is GetTeacherFinalTestQuestionsLoading) {
                    return _buildLoadingState();
                  }

                  if (state is GetTeacherFinalTestQuestionsFailure) {
                    return _buildErrorState(state.error);
                  }

                  if (state is GetTeacherFinalTestQuestionsSuccess) {
                    final questions =
                        state.getTeacherFinalTestQuestions?.questions;

                    if (questions == null || questions.isEmpty) {
                      return _buildEmptyState();
                    }

                    return _buildQuestionsContent(questions);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.lmcBlue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.background2,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              "Final Test Questions",
              style: TextStyle(
                color: AppColors.lmcBlue,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.lmcBlue),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.error_outline, color: Colors.red, size: 40.sp),
            ),
            SizedBox(height: 20.h),
            Text(
              "Error Loading Questions",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lmcBlue,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lmcBlue.withOpacity(0.7),
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap:
                  () => context
                      .read<GetTeacherFinalTestQuestionsCubit>()
                      .fetchFinalTestQuestions(widget.testId),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
                decoration: BoxDecoration(
                  color: AppColors.lmcBlue,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lmcBlue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.lmcOrange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.quiz_outlined,
                color: AppColors.lmcOrange,
                size: 40.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "No Questions Yet",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lmcBlue,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Start building your final test by adding questions",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lmcBlue.withOpacity(0.7),
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            _buildAddQuestionsButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsContent(List<Questions> questions) {
    int totalPoints = questions.fold(
      0,
      (sum, question) => sum + (question.point ?? 0),
    );

    return Column(
      children: [
        _buildStatsSection(questions.length, totalPoints),
        _buildAddQuestionSection(),
        Expanded(child: _buildQuestionsList(questions)),
      ],
    );
  }

  Widget _buildStatsSection(int totalQuestions, int totalPoints) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              "Total Questions",
              totalQuestions.toString(),
              Icons.quiz,
              AppColors.lmcBlue,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildStatCard(
              "Total Points",
              totalPoints.toString(),
              Icons.grade,
              AppColors.lmcOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lmcBlue.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddQuestionSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Add new question",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lmcBlue,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.lmcOrange.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed:
                  () => Navigator.pushNamed(
                    context,
                    Routes.add_final_test_question,
                    arguments: widget.testId,
                  ).then((_) {
                    context
                        .read<GetTeacherFinalTestQuestionsCubit>()
                        .fetchFinalTestQuestions(widget.testId);
                  }),
              icon: Icon(Icons.add, size: 24.sp, color: AppColors.lmcOrange),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddQuestionsButton() {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            Routes.add_final_test_question,
            arguments: widget.testId,
          ).then((_) {
            context
                .read<GetTeacherFinalTestQuestionsCubit>()
                .fetchFinalTestQuestions(widget.testId);
          }),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
        decoration: BoxDecoration(
          color: AppColors.lmcOrange,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.lmcOrange.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              "Add Questions",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsList(List<Questions> questions) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: questions.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder:
            (context, index) => _buildQuestionCard(questions[index], index + 1),
      ),
    );
  }

  Widget _buildQuestionCard(Questions question, int questionNumber) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lmcBlue.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(questionNumber, question.type, question.point),
          SizedBox(height: 12.h),
          _buildQuestionText(question.questionText),
          if (question.media?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),
            _buildMediaSection(question.media!),
          ],
          if (question.choices?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),
            _buildChoicesSection(question.choices!),
          ],
          if (question.correctAnswer?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),
            _buildCorrectAnswerSection(question.correctAnswer!),
          ],
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(int questionNumber, String? type, int? points) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.lmcBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            'Q$questionNumber',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lmcBlue,
            ),
          ),
        ),
        const Spacer(),
        _buildQuestionTypeChip(type),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.lmcOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.grade, size: 14.sp, color: AppColors.lmcOrange),
              SizedBox(width: 4.w),
              Text(
                '${points ?? 0} pts',
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
    );
  }

  Widget _buildQuestionTypeChip(String? type) {
    Color chipColor = AppColors.lmcBlue;
    String displayType = 'Text';

    switch (type?.toLowerCase()) {
      case 'multiple_choice':
      case 'mcq':
        chipColor = Colors.purple;
        displayType = 'MCQ';
        break;
      case 'true_false':
        chipColor = AppColors.lmcOrange;
        displayType = 'T/F';
        break;
      case 'essay':
      case 'text':
        chipColor = Colors.teal;
        displayType = 'Essay';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        displayType,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: chipColor,
        ),
      ),
    );
  }

  Widget _buildQuestionText(String? questionText) {
    return Text(
      questionText ?? 'No question text',
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.lmcBlue,
        height: 1.4,
      ),
    );
  }

  Widget _buildMediaSection(String media) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.lmcBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lmcBlue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.attachment, size: 18.sp, color: AppColors.lmcBlue),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Media: $media',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lmcBlue.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoicesSection(String choices) {
    List<String> choicesList = [];
    try {
      if (choices.startsWith('[')) {
        choicesList =
            choices
                .replaceAll('[', '')
                .replaceAll(']', '')
                .replaceAll('"', '')
                .split(',')
                .map((e) => e.trim())
                .toList();
      } else {
        choicesList = choices.split(',').map((e) => e.trim()).toList();
      }
    } catch (e) {
      choicesList = [choices];
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.lmcBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choices:',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lmcBlue,
            ),
          ),
          SizedBox(height: 8.h),
          ...choicesList.asMap().entries.map((entry) {
            String letter = String.fromCharCode(65 + entry.key);
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: AppColors.lmcBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lmcBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCorrectAnswerSection(String correctAnswer) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 18.sp, color: Colors.green),
          SizedBox(width: 8.w),
          Text(
            'Correct Answer: ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: Text(
              correctAnswer,
              style: TextStyle(fontSize: 14.sp, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

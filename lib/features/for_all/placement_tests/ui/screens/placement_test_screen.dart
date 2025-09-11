import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/repo/placement_test_di.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/cubit/placement_test_cubit.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/cubit/placement_test_state.dart';
import 'package:lmc_app/features/for_all/placement_tests/ui/models/audio_player_widget.dart';
import 'package:lmc_app/features/for_all/placement_tests/ui/models/question_widget.dart';
import 'package:lmc_app/features/for_all/placement_tests/ui/models/test_result_widget.dart';

class PlacementTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getPlacementTestCubit()..startTest(),
      child: PlacementTestView(),
    );
  }
}

class PlacementTestView extends StatefulWidget {
  @override
  _PlacementTestViewState createState() => _PlacementTestViewState();
}

class _PlacementTestViewState extends State<PlacementTestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: BlocConsumer<PlacementTestCubit, PlacementTestState>(
          listener: (context, state) {
            if (state is PlacementTestError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
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
                Expanded(
                  child: _buildBody(context, state),
                ),
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
                  "Placement Test",
                  style: TextStyle(
                    color: AppColors.lmcBlue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "English Assessment",
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

  Widget _buildBody(BuildContext context, PlacementTestState state) {
    if (state is PlacementTestInitial || state is PlacementTestLoading) {
      return _buildLoadingWidget();
    } else if (state is PlacementTestQuestionLoaded) {
      return _buildQuestionWidget(context, state);
    } else if (state is PlacementTestSubmitting) {
      return _buildSubmittingWidget();
    } else if (state is PlacementTestTimeUp) {
      return _buildTimeUpWidget();
    } else if (state is PlacementTestAutoSubmitting) {
      return _buildAutoSubmittingWidget();
    } else if (state is PlacementTestCompleted) {
      return TestResultWidget(result: state.result);
    } else if (state is PlacementTestError) {
      return _buildErrorWidget(context, state.message);
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
              'Loading...',
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

  Widget _buildSubmittingWidget() {
    return Center(
      child: Container(
        width: 200.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.lmcOrange.withOpacity(0.1),
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
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.lmcOrange),
                strokeWidth: 2.5,
              ),
            ),
            verticalSpace(12.h),
            Text(
              'Submitting...',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lmcOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeUpWidget() {
    return Center(
      child: Container(
        width: 240.w,
        height: 140.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.red.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.timer_1,
              size: 32.sp,
              color: Colors.red,
            ),
            verticalSpace(12.h),
            Text(
              'Time\'s Up!',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            verticalSpace(4.h),
            Text(
              'Finalizing results...',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red.withOpacity(0.7),
              ),
            ),
            verticalSpace(12.h),
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoSubmittingWidget() {
    return Center(
      child: Container(
        width: 240.w,
        height: 120.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.lmcOrange.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 28.w,
              height: 28.w,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.lmcOrange),
                strokeWidth: 2.5,
              ),
            ),
            verticalSpace(12.h),
            Text(
              'Finalizing Test',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.lmcOrange,
              ),
            ),
            verticalSpace(4.h),
            Text(
              'Auto-submitting...',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.lmcOrange.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerWidget(Duration remainingTime) {
    final minutes = remainingTime.inMinutes;
    final seconds = remainingTime.inSeconds % 60;
    final isLowTime = remainingTime.inMinutes < 5;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: (isLowTime ? Colors.red : AppColors.lmcBlue).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: (isLowTime ? Colors.red : AppColors.lmcBlue).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.timer_1,
            color: isLowTime ? Colors.red : AppColors.lmcBlue,
            size: 16.sp,
          ),
          horizontalSpace(6.w),
          Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isLowTime ? Colors.red : AppColors.lmcBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWidget(
    BuildContext context,
    PlacementTestQuestionLoaded state,
  ) {
    return Column(
      children: [
        // Timer and Question info
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getSectionColor(state.question.section).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getSectionIcon(state.question.section),
                      color: _getSectionColor(state.question.section),
                      size: 14.sp,
                    ),
                    horizontalSpace(6.w),
                    Text(
                      'Q${state.questionNumber}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: _getSectionColor(state.question.section),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              _buildTimerWidget(state.remainingTime),
            ],
          ),
        ),

        verticalSpace(16.h),

        // Low time warning
        if (state.remainingTime.inMinutes < 5)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.red.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Iconsax.warning_2, color: Colors.red, size: 14.sp),
                horizontalSpace(8.w),
                Text(
                  'Less than 5 minutes remaining',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

        verticalSpace(16.h),

        // Audio player for listening questions
        if (state.question.isListeningQuestion && state.question.media != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: AudioPlayerWidget(
              audioUrl: state.question.media!.replaceAll(
                'localhost',
                ApiConstants.ip,
              ),
            ),
          ),

        verticalSpace(16.h),

        // Question content
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: QuestionWidget(
              question: state.question,
              selectedAnswerId: state.selectedAnswerId,
              onAnswerSelected: (answerId) {
                context.read<PlacementTestCubit>().selectAnswer(answerId);
              },
            ),
          ),
        ),

        // Submit button
        Container(
          padding: EdgeInsets.all(24.w),
          child: SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () => context.read<PlacementTestCubit>().submitAnswer(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lmcOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                state.selectedAnswerId != null ? 'Submit Answer' : 'Skip Question',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.red.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.warning_2,
              size: 40.sp,
              color: Colors.red,
            ),
            verticalSpace(16.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            verticalSpace(8.h),
            Text(
              message,
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
                  context.read<PlacementTestCubit>().startTest();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Try Again',
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

  Color _getSectionColor(String section) {
    switch (section.toLowerCase()) {
      case 'listening':
        return Colors.purple;
      case 'reading':
        return AppColors.lmcOrange;
      case 'language use':
        return Colors.green;
      default:
        return AppColors.lmcBlue;
    }
  }

  IconData _getSectionIcon(String section) {
    switch (section.toLowerCase()) {
      case 'listening':
        return Iconsax.headphone;
      case 'reading':
        return Iconsax.book_1;
      case 'language use':
        return Iconsax.language_square;
      default:
        return Iconsax.message_question;
    }
  }
}
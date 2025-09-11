import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/di/dependency_injection.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/helpers/states_widgets.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/get_all_final_test_questions_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/stu_get_final_test_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/stu_get_final_test_state.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/submit_final_test_answer_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/submit_final_test_result_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/ui/screens/final_test_questions_screen.dart';
import 'package:lmc_app/features/student_features/student_final_test/ui/screens/final_test_resault_screen.dart';

class StudentFinalTestScreen extends StatelessWidget {
  final int courseId;

  const StudentFinalTestScreen({Key? key, required this.courseId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      appBar: _buildAppBar(context),
      body: BlocConsumer<StuGetFinalTestCubit, StuGetFinalTestState>(
        listener: (context, state) {
          if (state is StuGetFinalTestFailure) {
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
          if (state is StuGetFinalTestLoading) {
            return StateWidgets.buildLoadingState(
              message: 'Loading Final Test...',
              primaryColor: AppColors.lmcBlue,
              accentColor: AppColors.lmcOrange,
            );
          }

          if (state is StuGetFinalTestFailure) {
            return StateWidgets.buildErrorState(
              title: 'Failed to Load Final Test',
              subtitle: state.error,
              icon: Iconsax.warning_2_copy,
              onRetry:
                  () => context
                      .read<StuGetFinalTestCubit>()
                      .fetchStuGetFinalTest(courseId),
              retryButtonText: 'Retry',
            );
          }

          if (state is StuGetFinalTestSuccess) {
            final finalTest = state.stuGetFinalTestModel.finalTest;
            final message = state.stuGetFinalTestModel.message;

            if (finalTest == null) {
              return _NoTestAvailableWidget(message: message);
            }

            return _FinalTestContent(finalTest: finalTest, courseId: courseId);
          }

          return StateWidgets.buildLoadingState(
            message: 'Initializing...',
            primaryColor: AppColors.lmcBlue,
            accentColor: AppColors.lmcOrange,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background2,
      elevation: 0,
      title: Text(
        'Final Test',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class _FinalTestContent extends StatelessWidget {
  final dynamic finalTest;
  final int courseId;

  const _FinalTestContent({required this.finalTest, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _TestOverviewCard(finalTest: finalTest),
          verticalSpace(24),
          _TestStatsCard(finalTest: finalTest),
          verticalSpace(24),
          _InstructionsCard(),
          verticalSpace(40),
          _StartTestButton(finalTest: finalTest),
          verticalSpace(40),
        ],
      ),
    );
  }
}

class _TestOverviewCard extends StatelessWidget {
  final dynamic finalTest;

  const _TestOverviewCard({required this.finalTest});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      withBorder: true,
      width: double.infinity,
      topLeft: 20.r,
      topRight: 20.r,
      bottomRight: 20.r,
      bottomLeft: 20.r,
      firstColor: Colors.white.withOpacity(0.9),
      secondColor: Colors.white.withOpacity(0.8),
      firstBlurOpacity: 0.8,
      secondBlurOpacity: 0.5,
      sigmaX: 80,
      sigmaY: 80,
      height: 160.h,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.lmcBlue.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              _TestHeader(),
              verticalSpace(20),
              _TestTitle(title: finalTest.title),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.lmcBlue.withOpacity(0.8),
                AppColors.lmcBlue.withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(50.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.lmcBlue.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Iconsax.document_text_1_copy,
            size: 32.w,
            color: AppColors.background2,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          'FINAL ASSESSMENT',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.lmcBlue,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _TestTitle extends StatelessWidget {
  final String? title;

  const _TestTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'Final Test',
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _TestStatsCard extends StatelessWidget {
  final dynamic finalTest;

  const _TestStatsCard({required this.finalTest});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      withBorder: true,
      width: double.infinity,
      topLeft: 16.r,
      topRight: 16.r,
      bottomRight: 16.r,
      bottomLeft: 16.r,
      firstColor: AppColors.lightLmcBlue.withOpacity(0.1),
      secondColor: AppColors.lightLmcBlue.withOpacity(0.05),
      firstBlurOpacity: 0.8,
      secondBlurOpacity: 0.5,
      sigmaX: 80,
      sigmaY: 80,
      height: 220.h,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(icon: Iconsax.chart_copy, title: 'Test Details'),
            verticalSpace(20),
            _StatsRow(
              icon: Iconsax.clock_copy,
              label: 'Duration',
              value: '${finalTest.duration ?? 0} minutes',
              color: AppColors.lmcOrange,
            ),
            verticalSpace(16),
            _StatsRow(
              icon: Iconsax.star_1_copy,
              label: 'Total Marks',
              value: '${finalTest.mark ?? 0} points',
              color: Colors.green,
            ),
            verticalSpace(16),
            if (finalTest.user != null)
              _StatsRow(
                icon: Iconsax.teacher_copy,
                label: 'Instructor',
                value: finalTest.user!.name ?? 'Unknown',
                color: AppColors.lmcBlue,
              ),
          ],
        ),
      ),
    );
  }
}

class _InstructionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      withBorder: true,
      width: double.infinity,
      topLeft: 16.r,
      topRight: 16.r,
      bottomRight: 16.r,
      bottomLeft: 16.r,
      firstColor: AppColors.background2.withOpacity(0.7),
      secondColor: AppColors.background2.withOpacity(0.6),
      firstBlurOpacity: 0.8,
      secondBlurOpacity: 0.5,
      sigmaX: 80,
      sigmaY: 80,
      height: 270.h,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.background2.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(
                icon: Iconsax.info_circle_copy,
                title: 'Important Instructions',
                iconColor: AppColors.lightLmcBlue,
              ),
              verticalSpace(20),
              _InstructionItem(
                icon: Iconsax.eye_copy,
                text: 'Read each question carefully before answering',
              ),
              verticalSpace(12),
              _InstructionItem(
                icon: Iconsax.arrow_circle_left_copy,
                text: 'You cannot go back once you submit an answer',
              ),
              verticalSpace(12),
              _InstructionItem(
                icon: Iconsax.wifi_copy,
                text: 'Ensure you have a stable internet connection',
              ),
              verticalSpace(12),
              _InstructionItem(
                icon: Iconsax.timer_1_copy,
                text: 'Test will auto-submit when time runs out',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;

  const _SectionHeader({
    required this.icon,
    required this.title,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (iconColor ?? AppColors.lmcBlue).withOpacity(0.8),
                (iconColor ?? AppColors.lmcBlue).withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColors.background2, size: 20.w),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatsRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.background2, size: 16.w),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lmcBlue,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InstructionItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InstructionItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColors.lightLmcBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              color: AppColors.lightLmcBlue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(icon, size: 14.w, color: AppColors.lightLmcBlue),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.lmcBlue,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _StartTestButton extends StatelessWidget {
  final dynamic finalTest;

  const _StartTestButton({required this.finalTest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green[600]!, Colors.green[700]!],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => _navigateToTestQuestions(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.play_circle_copy, color: Colors.white, size: 24.w),
                SizedBox(width: 12.w),
                Text(
                  'START TEST',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToTestQuestions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MultiBlocProvider(
              providers: [
                BlocProvider<SubmitFinalTestResultCubit>(
                  create: (context) => getIt<SubmitFinalTestResultCubit>(),
                ),
              ],
              child: FinalTestResultScreen(testId: finalTest.id),
            ),
      ),
    );
  }
}

class _NoTestAvailableWidget extends StatelessWidget {
  final String? message;

  const _NoTestAvailableWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: GlassContainer(
          withBorder: true,
          width: double.infinity,
          topLeft: 20.r,
          topRight: 20.r,
          bottomRight: 20.r,
          bottomLeft: 20.r,
          firstColor: AppColors.background2.withOpacity(0.05),
          secondColor: AppColors.background2.withOpacity(0.02),
          firstBlurOpacity: 0.8,
          secondBlurOpacity: 0.5,
          sigmaX: 80,
          sigmaY: 80,
          height: 200.h,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.background2.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.lmcBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Icon(
                      Iconsax.document_text_copy,
                      size: 40.w,
                      color: AppColors.lmcBlue,
                    ),
                  ),
                  verticalSpace(20),
                  Text(
                    'No Final Test Available',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lmcBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (message != null) ...[
                    verticalSpace(12),
                    Text(
                      message!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.lmcBlue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

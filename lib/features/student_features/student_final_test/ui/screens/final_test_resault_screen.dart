import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/di/dependency_injection.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/stu_final_test_resault_model.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/submit_final_test_result_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/get_all_final_test_questions_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/submit_final_test_answer_cubit.dart';
import 'package:lmc_app/features/student_features/student_final_test/ui/screens/final_test_questions_screen.dart';

class FinalTestResultScreen extends StatefulWidget {
  final int testId;
  const FinalTestResultScreen({super.key, required this.testId});

  @override
  State<FinalTestResultScreen> createState() => _FinalTestResultScreenState();
}

class _FinalTestResultScreenState extends State<FinalTestResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubmitFinalTestResultCubit>().submitFinalTestResult(
        testId: widget.testId.toString(),
        context: context,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getGradeColor(int? grade) {
    if (grade == null) return CupertinoColors.systemGrey;
    if (grade >= 90) return CupertinoColors.systemGreen;
    if (grade >= 80) return CupertinoColors.systemBlue;
    if (grade >= 70) return CupertinoColors.systemOrange;
    if (grade >= 60) return CupertinoColors.systemYellow;
    return CupertinoColors.systemRed;
  }

  String _getGradeLabel(int? grade) {
    if (grade == null) return 'N/A';
    if (grade >= 90) return 'Excellent';
    if (grade >= 80) return 'Very Good';
    if (grade >= 70) return 'Good';
    if (grade >= 60) return 'Pass';
    return 'Needs Improvement';
  }

  Widget _buildResultCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    String? subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.systemGrey2,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(radius: 20),
          const SizedBox(height: 16),
          Text(
            'Processing your test results...',
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey.resolveFrom(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CupertinoColors.systemRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                CupertinoIcons.exclamationmark_triangle,
                size: 48,
                color: CupertinoColors.systemRed,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Error Loading Results',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemRed,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 24),
            CupertinoButton.filled(
              onPressed: () {
                context
                    .read<SubmitFinalTestResultCubit>()
                    .submitFinalTestResult(
                      testId: widget.testId.toString(),
                      context: context,
                    );
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  // NEW: Take Test Screen for score = 0
  Widget _buildTakeTestScreen() {
    _animationController.forward();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: EdgeInsets.all(40.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.lmcBlue.withOpacity(0.1),
                          AppColors.lmcBlue.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.lmcOrange.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.document_text_1_copy,
                            size: 60.sp,
                            color: AppColors.lmcOrange,
                          ),
                        ),
                        verticalSpace(24),
                        Text(
                          'Time for Your Final Test!',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lmcBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(12),
                        Text(
                          'You need to complete the final test to get your grade.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.lmcBlue.withOpacity(0.7),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                verticalSpace(40),

                // Take Test Button
                Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.lmcOrange,
                        AppColors.lmcOrange.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lmcOrange.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () => _navigateToTakeTest(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.play_circle_copy,
                              color: Colors.white,
                              size: 24.w,
                            ),
                            horizontalSpace(12),
                            Text(
                              'TAKE FINAL TEST',
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
                ),

                verticalSpace(20),

                // Continue Button (go back)
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.lmcBlue, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToTakeTest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MultiBlocProvider(
              providers: [
                BlocProvider<GetAllFinalTestQuestionsCubit>(
                  create: (context) => getIt<GetAllFinalTestQuestionsCubit>(),
                ),
                BlocProvider<SubmitFinalTestAnswerCubit>(
                  create: (context) => getIt<SubmitFinalTestAnswerCubit>(),
                ),
              ],
              child: FinalTestQuestionsScreen(testId: widget.testId),
            ),
      ),
    );
  }

  Widget _buildSuccessState(StuFinalTestResaultModel result) {
    // Check if score and grade are 0 - show take test screen
    if ((result.finalTestScore == null || result.finalTestScore == 0) &&
        (result.finalGrade == null || result.finalGrade == 0)) {
      return _buildTakeTestScreen();
    }

    // Otherwise show normal results
    _animationController.forward();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getGradeColor(result.finalGrade).withOpacity(0.1),
                          _getGradeColor(result.finalGrade).withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          result.finalGrade != null && result.finalGrade! >= 60
                              ? CupertinoIcons.check_mark_circled_solid
                              : CupertinoIcons.xmark_circle_fill,
                          size: 80,
                          color: _getGradeColor(result.finalGrade),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Test Complete!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: CupertinoDynamicColor.resolve(
                              CupertinoColors.label,
                              context,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (result.message != null)
                          Text(
                            result.message!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey.resolveFrom(
                                context,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildResultCard(
                          title: 'Test Score',
                          value: '${result.finalTestScore ?? 0}',
                          subtitle: _getGradeLabel(result.finalGrade),
                          icon: CupertinoIcons.star_fill,
                          color: _getGradeColor(result.finalGrade),
                        ),
                        _buildResultCard(
                          title: 'Bonus Points',
                          value: '+${result.bonus ?? 0}',
                          icon: CupertinoIcons.gift_fill,
                          color: CupertinoColors.systemPurple,
                        ),
                        _buildResultCard(
                          title: 'Final Grade',
                          value: '${result.finalGrade ?? 0}',
                          subtitle: _getGradeLabel(result.finalGrade),
                          icon: CupertinoIcons.text_badge_star,
                          color: _getGradeColor(result.finalGrade),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Continue'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CupertinoButton.filled(
                        onPressed:
                            () => Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst),
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Test Results'),
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: BlocConsumer<
          SubmitFinalTestResultCubit,
          SubmitFinalTestResultState
        >(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SubmitFinalTestResultLoading) {
              return _buildLoadingState();
            } else if (state is SubmitFinalTestResultFailure) {
              return _buildErrorState(state.error);
            } else if (state is SubmitFinalTestResultSuccess) {
              return _buildSuccessState(state.result);
            }
            return _buildLoadingState();
          },
        ),
      ),
    );
  }
}

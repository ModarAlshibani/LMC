import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/selftest_details/ui/widgets/question_viewer.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';

class TeacherSelfTestDetails extends StatefulWidget {
  final SelfTests selfTest;
  const TeacherSelfTestDetails({super.key, required this.selfTest});

  @override
  State<TeacherSelfTestDetails> createState() => _TeacherSelfTestDetailsState();
}

class _TeacherSelfTestDetailsState extends State<TeacherSelfTestDetails> {
  int currentIndex = 0;

  void goToNextQuestion() {
    final length = widget.selfTest.questions?.length ?? 0;
    if (currentIndex < length - 1) {
      setState(() => currentIndex++);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8.w),
              Text("You've reached the last question"),
            ],
          ),
          backgroundColor: AppColors.lmcBlue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.selfTest.questions ?? [];

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
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
                      widget.selfTest.title ?? "Self Test",
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
            ),

            // Description Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.lightLmcBlue,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.selfTest.description ?? "No description available",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lmcBlue,
                  height: 1.4,
                ),
              ),
            ),

            verticalSpace(20.h),

            // Main Content Section
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.lmcBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Questions header
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Questions",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.background2.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: IconButton(
                              onPressed:
                                  () => Navigator.pushNamed(
                                    context,
                                    Routes.add_selftest_question,
                                    arguments: widget.selfTest,
                                  ),
                              icon: Icon(
                                Icons.add,
                                size: 24.sp,
                                color: AppColors.lmcOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Questions content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.lmcBlue.withOpacity(0.05),
                                AppColors.lmcBlue.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.lmcBlue.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child:
                              questions.isEmpty
                                  ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(24.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.lmcBlue
                                                .withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.quiz_outlined,
                                            size: 48.sp,
                                            color: AppColors.lmcBlue
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                        verticalSpace(16.h),
                                        Text(
                                          "No questions added yet",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.lmcBlue,
                                          ),
                                        ),
                                        verticalSpace(8.h),
                                        Text(
                                          "Tap the + button to add your first question",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.lmcBlue
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: QuestionViewer(
                                      question: questions[currentIndex],
                                      index: currentIndex,
                                      total: questions.length,
                                    ),
                                  ),
                        ),
                      ),
                    ),

                    // Navigation buttons
                    if (questions.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          children: [
                            // Previous button
                            if (currentIndex > 0)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => currentIndex--),
                                  child: Container(
                                    height: 56.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.lmcBlue,
                                      borderRadius: BorderRadius.circular(16.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.lmcBlue.withOpacity(
                                            0.3,
                                          ),
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 20.sp,
                                          color: AppColors.background2,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Previous",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.background2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            if (currentIndex > 0) SizedBox(width: 16.w),

                            // Next button
                            Expanded(
                              child: GestureDetector(
                                onTap: goToNextQuestion,
                                child: Container(
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.lmcOrange,
                                        AppColors.lmcOrange.withOpacity(0.8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.lmcOrange.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentIndex < questions.length - 1
                                            ? "Next"
                                            : "Finish",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.background2,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(
                                        currentIndex < questions.length - 1
                                            ? Icons.arrow_forward_ios
                                            : Icons.check,
                                        size: 20.sp,
                                        color: AppColors.background2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            verticalSpace(20.h),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
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
        SnackBar(content: Text("✅ You've reached the last question")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.selfTest.questions ?? [];

    return Scaffold(
      backgroundColor: AppColors.lmcBlue,
      body: Stack(
        children: [
          Positioned(
            top: 30.h,
            left: 20.w,
            child: Text(
              widget.selfTest.title ?? "",
              style: TextStyle(
                color: AppColors.background2,
                fontSize: 30.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            top: 85.h,
            bottom: 0.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lightLmcBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "    ${widget.selfTest.description ?? ""}",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            top: 180.h,
            bottom: 0,
            left: 0.w,
            right: 0.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  verticalSpace(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Questions:",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lmcBlue,
                          ),
                        ),
                        IconButton(
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                Routes.add_selftest_question,
                                arguments: widget.selfTest,
                              ),
                          icon: Icon(
                            Icons.add,
                            size: 32.sp,
                            color: AppColors.lmcOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10.h),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: GlassContainer(
                        width: double.infinity,
                        height: double.infinity,
                        topLeft: 15,
                        topRight: 15,
                        bottomRight: 15,
                        bottomLeft: 15,
                        withBorder: false,
                        firstColor: AppColors.lmcBlue,
                        secondColor: AppColors.lmcBlue,
                        firstBlurOpacity: 0.1,
                        secondBlurOpacity: 0.2,
                        child:
                            questions.isEmpty
                                ? Center(
                                  child: Text(
                                    "No questions added yet.",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                : QuestionViewer(
                                  question: questions[currentIndex],
                                  index: currentIndex,
                                  total: questions.length,
                                ),
                      ),
                    ),
                  ),
                  verticalSpace(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: [
                        if (currentIndex > 0)
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => currentIndex--),
                              child: Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: AppColors.lmcBlue,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.lmcBlue.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 28.sp,
                                    color: AppColors.background2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(width: currentIndex > 0 ? 12.w : 0),
                        Expanded(
                          child: GestureDetector(
                            onTap: goToNextQuestion,
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: AppColors.lmcOrange,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 28.sp,
                                  color: AppColors.lmcBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

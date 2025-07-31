import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/guest_features/guest_homePage/ui/widgets/top_container.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/ui/widgets/teacher_lesson_flashcards_list.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/ui/widgets/selftests_list.dart';

class TeacherLessonFlashcardsScreen extends StatelessWidget {
  final int lessonId;
  const TeacherLessonFlashcardsScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
                      "Lesson Flashcards",
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add new flashcard",
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
                            Routes.add_flashcard,
                            arguments: lessonId,
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
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TeacherLessonFlashcardsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';

class TeacherLessonFlashcardsOutside extends StatelessWidget {
  final FlashCards flashCard;

  const TeacherLessonFlashcardsOutside({super.key, required this.flashCard});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print(flashCard.id),
      // onTap: () => Navigator.pushNamed(context, Routes.teacher_lessons_details, arguments: flashCard,),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: GlassContainer(
          withBorder: false,
          width: double.infinity,
          height: 140.h,
          topLeft: 10,
          topRight: 10,
          bottomRight: 10,
          bottomLeft: 10,
          firstColor: AppColors.lmcBlue,
          secondColor: AppColors.lmcBlue,
          firstBlurOpacity: 0.3,
          secondBlurOpacity: 0.25,
          sigmaX: 100,
          sigmaY: 100,
          child: Row(
            children: [
              horizontalSpace(10.w),
              Container(
                width: 130.w,
                height: 130.h,
                decoration: BoxDecoration(
                  color: AppColors.lmcBlue,
                  borderRadius: BorderRadius.circular(10),
               
                ),
                child: SizedBox.shrink(),
              ),
              horizontalSpace(20.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        flashCard.content!,
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        flashCard.translation!,
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(10.w),
            ],
          ),
        ),
      ),
    );
  }
}

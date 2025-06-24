import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';

class TeacherLessonFlashcardsOutside extends StatefulWidget {
  final FlashCards flashCard;

  const TeacherLessonFlashcardsOutside({super.key, required this.flashCard});

  @override
  State<TeacherLessonFlashcardsOutside> createState() =>
      _TeacherLessonFlashcardsOutsideState();
}

class _TeacherLessonFlashcardsOutsideState
    extends State<TeacherLessonFlashcardsOutside>
    with SingleTickerProviderStateMixin {
  bool _showFront = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _showFront = !_showFront),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotate = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (context, child) {
              final isUnder = (ValueKey(_showFront) != child?.key);
              var tilt = (animation.value - 0.5).abs() - 0.5;
              tilt *= isUnder ? -0.003 : 0.003;
              final rotationY =
                  isUnder ? pi * animation.value : pi * (1 - animation.value);

              return Transform(
                transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        child:
            _showFront
                ? _buildCard(widget.flashCard.content!, true)
                : _buildCard(widget.flashCard.translation!, false),
        switchInCurve: Curves.easeInOut,
        layoutBuilder:
            (currentChild, previousChildren) => Stack(
              alignment: Alignment.center,
              children: [
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            ),
      ),
    );
  }

  Widget _buildCard(String text, bool isFront) {
    return Container(
      key: ValueKey(isFront),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: GlassContainer(
        withBorder: false,
        width: double.infinity,
        height: 100.h,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Container(
                  width: 200.w,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: AppColors.lmcBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:
                      () => Navigator.pushNamed(
                        context,
                        Routes.edit_flashcard,
                        arguments: {
                          'lessonId': widget.flashCard.lessonId,
                          'flashcardId': widget.flashCard.id,
                          'oldContent': widget.flashCard.content,
                          'oldTranslation': widget.flashCard.translation,
                        },
                      ),
                  icon: Icon(
                    Icons.mode_edit_outline_outlined,
                    size: 30,
                    color: AppColors.lmcBlue,
                  ),
                ),
                verticalSpace(20),
                IconButton(
                  onPressed:
                      () => _deleteFlashcard(
                        widget.flashCard.id,
                        context,
                        widget.flashCard.lessonId,
                      ),
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    size: 30,
                    color: AppColors.lmcOrange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _deleteFlashcard(int? flashcardId, BuildContext context, int? lessonId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: GlassContainer(
          width: 350.w,
          height: 230.h,
          topLeft: 15,
          topRight: 15,
          bottomRight: 15,
          bottomLeft: 15,
          firstColor: AppColors.lightLmcBlue,
          secondColor: AppColors.lightLmcBlue,
          firstBlurOpacity: 0.45,
          secondBlurOpacity: 0.35,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Are you sure you want to delete this flashcard ?",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ApiService().DeleteFlashcard(
                      flashcardId: flashcardId!,
                      context: context,
                    );
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.teacher_lessons_flashcards,
                      arguments: lessonId,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lmcOrange,
                    minimumSize: Size(200.w, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.background2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background2,
                    minimumSize: Size(200.w, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.lmcBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

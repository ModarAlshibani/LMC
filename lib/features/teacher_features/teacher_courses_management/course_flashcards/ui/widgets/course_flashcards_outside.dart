import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/helpers/tts_helper.dart'; // Import your TTS helper
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/data/course_flashcards_model.dart';

class CourseFlashcardsOutside extends StatefulWidget {
  final FlashCards flashCard;

  const CourseFlashcardsOutside({super.key, required this.flashCard});

  @override
  State<CourseFlashcardsOutside> createState() =>
      _CourseFlashcardsOutsideState();
}

class _CourseFlashcardsOutsideState
    extends State<CourseFlashcardsOutside>
    with SingleTickerProviderStateMixin {
  bool _showFront = true;
  bool _isFlipping = false;
  late TTSHelper _ttsHelper;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    _ttsHelper = TTSHelper();
    await _ttsHelper.initialize(
      language: "en-US",
      speechRate: 0.5,
      volume: 1.0,
      pitch: 1.0,
      onSpeakingStart: () {
        if (mounted) {
          setState(() {});
        }
      },
      onSpeakingComplete: () {
        if (mounted) {
          setState(() {});
        }
      },
      onError: (error) {
        if (mounted) {
          _showTtsUnavailableSnackbar();
        }
      },
    );
  }

  Future<void> _speak(String text) async {
    if (!_ttsHelper.ttsAvailable) {
      _showTtsUnavailableSnackbar();
      return;
    }
    await _ttsHelper.speak(text);
  }

  void _showTtsUnavailableSnackbar() {
    TTSHelper.showTTSUnavailableSnackbar(
      context,
      backgroundColor: AppColors.lmcOrange,
    );
  }

  @override
  void dispose() {
    _ttsHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: GestureDetector(
        onTap: () {
          if (!_isFlipping) {
            setState(() {
              _isFlipping = true;
              _showFront = !_showFront;
            });
          }
        },
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final rotate = Tween(begin: pi, end: 0.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
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
          layoutBuilder: (currentChild, previousChildren) {
            // Reset flipping state when animation completes
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_isFlipping) {
                setState(() {
                  _isFlipping = false;
                });
              }
            });
            return Stack(
              alignment: Alignment.center,
              children: [
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(String text, bool isFront) {
    return Container(
      key: ValueKey(isFront),

      child: GlassContainer(
        withBorder: true,
        width: double.infinity,
        height: 140.h,
        topLeft: 16.r,
        topRight: 16.r,
        bottomRight: 16.r,
        bottomLeft: 16.r,
        firstColor: AppColors.lightLmcBlue.withOpacity(0.06),
        secondColor: AppColors.lightLmcBlue.withOpacity(0.05),
        firstBlurOpacity: 0.8,
        secondBlurOpacity: 0.5,
        sigmaX: 80,
        sigmaY: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                    isFront
                        ? [
                          AppColors.lightLmcBlue.withOpacity(0.06),
                          AppColors.lightLmcBlue.withOpacity(0.05),
                        ]
                        : [
                          AppColors.lmcOrange.withOpacity(0.15),
                          AppColors.lmcOrange.withOpacity(0.1),
                        ],
              ),
            ),
            child: Stack(
              children: [
                // // Background pattern
                // Positioned.fill(
                //   child: CustomPaint(
                //     painter: PatternPainter(
                //       color: Colors.white.withOpacity(0.1),
                //     ),
                //   ),
                // ),

                // Card indicator
                Positioned(
                  top: 15.h,
                  left: 20.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lmcBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Text(
                      isFront ? "FRONT" : "BACK",
                      style: TextStyle(
                        color: AppColors.lmcBlue,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                // TTS Button
                Positioned(
                  top: 10.h,
                  right: 20.w,
                  child: GestureDetector(
                    onTap: () => _speak(text),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color:
                            _ttsHelper.ttsAvailable
                                ? AppColors.lmcBlue.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              _ttsHelper.ttsAvailable
                                  ? AppColors.lmcBlue.withOpacity(0.3)
                                  : Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        _ttsHelper.isSpeaking ? Icons.stop : Icons.volume_up,
                        color:
                            _ttsHelper.ttsAvailable
                                ? Colors.white
                                : Colors.grey,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),

                // Main content
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: AppColors.lmcBlue,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action buttons
                Positioned(
                  bottom: 15.h,
                  right: 20.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildActionButton(
                        icon: Icons.edit_outlined,
                        color: Colors.white.withOpacity(0.9),
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
                      ),
                      SizedBox(width: 10.w),
                      _buildActionButton(
                        icon: Icons.delete_outline,
                        color: AppColors.lmcOrange.withOpacity(0.9),
                        onPressed:
                            () => _deleteFlashcard(
                              widget.flashCard.id,
                              context,
                              widget.flashCard.lessonId,
                            ),
                      ),
                    ],
                  ),
                ),

                // Flip indicator
                Positioned(
                  bottom: 15.h,
                  left: 20.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lmcOrange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.touch_app,
                          size: 12.sp,
                          color: AppColors.lmcOrange.withOpacity(0.8),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Tap to flip",
                          style: TextStyle(
                            color: AppColors.lmcOrange.withOpacity(0.8),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 35.w,
        height: 35.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Icon(icon, color: color, size: 18.sp),
      ),
    );
  }
}

// Custom painter for background pattern
class PatternPainter extends CustomPainter {
  final Color color;

  PatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path = Path();

    // Create a subtle geometric pattern
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 3; j++) {
        final x = (i * size.width / 4) - 10;
        final y = (j * size.height / 2) - 10;

        path.addOval(Rect.fromCircle(center: Offset(x, y), radius: 2));
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _deleteFlashcard(int? flashcardId, BuildContext context, int? lessonId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              width: 320.w,
              height: 320.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lightLmcBlue.withOpacity(0.9),
                    AppColors.lightLmcBlue.withOpacity(0.7),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PatternPainter(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Delete icon
                        Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.delete_forever_outlined,
                            size: 30.sp,
                            color: Colors.redAccent,
                          ),
                        ),

                        verticalSpace(20),

                        Text(
                          "Delete Flashcard",
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        verticalSpace(12),

                        Text(
                          "Are you sure you want to delete this flashcard? This action cannot be undone.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        verticalSpace(30),

                        Row(
                          children: [
                            Expanded(
                              child: dialogueButton(
                                text: "Cancel",
                                backgroundColor: Colors.white.withOpacity(0.2),
                                textColor: Colors.white,
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: dialogueButton(
                                text: "Delete",
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget dialogueButton({
  required String text,
  required Color backgroundColor,
  required Color textColor,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      minimumSize: Size(double.infinity, 45.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0,
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
    ),
  );
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';

class QuestionViewer extends StatefulWidget {
  final Questions question;
  final int index;
  final int total;

  const QuestionViewer({
    super.key,
    required this.question,
    required this.index,
    required this.total,
  });

  @override
  State<QuestionViewer> createState() => _QuestionViewerState();
}

class _QuestionViewerState extends State<QuestionViewer>
    with TickerProviderStateMixin {
  VideoPlayerController? _videoController;
  AnimationController? _slideController;
  AnimationController? _bounceController;
  AnimationController? _pulseController;
  Animation<double>? _slideAnimation;
  Animation<double>? _bounceAnimation;
  Animation<double>? _pulseAnimation;
  bool _animationsInitialized = false;

  @override
  void initState() {
    super.initState();

    // Initialize animations with proper bounds
    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _bounceController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController!, curve: Curves.easeOutBack),
    );

    _bounceAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _bounceController!, curve: Curves.elasticOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController!, curve: Curves.easeInOut),
    );

    _animationsInitialized = true;

    // Start animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _slideController?.forward();
        _bounceController?.forward();
        _pulseController?.repeat(reverse: true);
      }
    });

    // Initialize video
    final media = widget.question.media;
    if (media != null && media.endsWith(".mp4")) {
      _videoController = VideoPlayerController.network(media)
        ..initialize().then((_) {
          if (mounted) {
            _videoController?.setLooping(true);
            _videoController?.play();
            setState(() {});
          }
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _slideController?.dispose();
    _bounceController?.dispose();
    _pulseController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8F9FA), Color(0xFFE8F4FD), Color(0xFFDEF2FF)],
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: AnimatedBuilder(
          animation: _slideAnimation ?? const AlwaysStoppedAnimation(1.0),
          builder: (context, child) {
            final slideValue = (_slideAnimation?.value ?? 1.0).clamp(0.0, 1.0);
            return Transform.translate(
              offset: Offset(0, (1 - slideValue) * 50),
              child: Opacity(
                opacity: slideValue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress and Question Header
                    _buildProgressHeader(),

                    verticalSpace(20.h),

                    // Media preview with glassmorphism effect
                    if (question.media != null)
                      _buildGlassMediaContainer(question.media!),

                    verticalSpace(20.h),

                    // Question Text with beautiful typography
                    _buildQuestionText(question.questionText ?? "-"),

                    verticalSpace(16.h),

                    // Question Type with animated badge
                    _buildQuestionTypeBadge(question.type ?? "UNKNOWN"),

                    verticalSpace(24.h),

                    // Answer choices with animations
                    if (question.type == "true_false")
                      _buildAnimatedTrueFalseAnswer(question.correctAnswer)
                    else if (question.choices != null &&
                        question.choices!.isNotEmpty)
                      _buildAnimatedChoicesList(
                        question.choices!,
                        question.correctAnswer,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    double progress = (widget.index + 1) / widget.total;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question ${widget.index + 1}",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.lmcOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: AppColors.lmcOrange.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  "${widget.index + 1}/${widget.total}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.lmcOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(12.h),
          // Animated progress bar
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  width: MediaQuery.of(context).size.width * 0.85 * progress,
                  height: 8.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.lmcOrange, Colors.yellow.shade400],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lmcOrange.withOpacity(0.5),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassMediaContainer(String url) {
    return AnimatedBuilder(
      animation: _bounceAnimation ?? const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        final bounceValue = (_bounceAnimation?.value ?? 1.0).clamp(0.1, 2.0);
        return Transform.scale(
          scale: bounceValue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  _buildMedia(url),
                  // Glassmorphism overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                        ],
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

  Widget _buildQuestionText(String questionText) {
    return AnimatedBuilder(
      animation: _pulseAnimation ?? const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        final pulseValue = (_pulseAnimation?.value ?? 1.0).clamp(0.8, 1.2);
        return Transform.scale(
          scale: pulseValue,
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.lmcOrange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Icon(
                    Iconsax.message_question,
                    color: AppColors.lmcOrange,
                    size: 24.sp,
                  ),
                ),
                horizontalSpace(16.w),
                Expanded(
                  child: Text(
                    questionText,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
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

  Widget _buildQuestionTypeBadge(String type) {
    return AnimatedBuilder(
      animation: _bounceAnimation ?? const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        final bounceValue = (_bounceAnimation?.value ?? 1.0).clamp(0.1, 2.0);
        return Transform.scale(
          scale: bounceValue,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.lmcOrange, Colors.deepOrange.shade400],
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lmcOrange.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.tag, color: Colors.white, size: 16.sp),
                horizontalSpace(8.w),
                Text(
                  type.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedChoicesList(
    List<String> choices,
    String? correctAnswer,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          choices.asMap().entries.map((entry) {
            final index = entry.key;
            final choice = entry.value;
            final isCorrect =
                choice.trim().toLowerCase() ==
                correctAnswer?.trim().toLowerCase();

            return AnimatedBuilder(
              animation: _slideAnimation ?? const AlwaysStoppedAnimation(1.0),
              builder: (context, child) {
                final slideValue = (_slideAnimation?.value ?? 1.0).clamp(
                  0.0,
                  1.0,
                );
                return Transform.translate(
                  offset: Offset((1 - slideValue) * 100, 0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      gradient:
                          isCorrect
                              ? LinearGradient(
                                colors: [
                                  AppColors.green.withOpacity(0.9),
                                  AppColors.green.withOpacity(0.7),
                                ],
                              )
                              : LinearGradient(
                                colors: [Colors.white, Colors.grey.shade50],
                              ),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color:
                            isCorrect ? AppColors.green : Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow:
                          isCorrect
                              ? [
                                BoxShadow(
                                  color: AppColors.green.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ]
                              : [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color:
                                isCorrect
                                    ? Colors.white
                                    : AppColors.lmcOrange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child:
                                isCorrect
                                    ? Icon(
                                      Iconsax.tick_circle,
                                      color: AppColors.green,
                                      size: 24.sp,
                                    )
                                    : Text(
                                      String.fromCharCode(
                                        65 + index,
                                      ), // A, B, C, D
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.lmcOrange,
                                      ),
                                    ),
                          ),
                        ),
                        horizontalSpace(16.w),
                        Expanded(
                          child: Text(
                            choice,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color:
                                  isCorrect
                                      ? Colors.white
                                      : Colors.grey.shade700,
                              fontWeight:
                                  isCorrect ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
    );
  }

  Widget _buildAnimatedTrueFalseAnswer(String? answer) {
    return AnimatedBuilder(
      animation: _bounceAnimation ?? const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        final bounceValue = (_bounceAnimation?.value ?? 1.0).clamp(0.1, 2.0);
        return Transform.scale(
          scale: bounceValue,
          child: Row(
            children: [
              Expanded(
                child: _buildTFBlock(
                  "True",
                  answer == "true",
                  Iconsax.tick_circle,
                ),
              ),
              horizontalSpace(16.w),
              Expanded(
                child: _buildTFBlock(
                  "False",
                  answer == "false",
                  Iconsax.close_circle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTFBlock(String label, bool isCorrect, IconData icon) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        gradient:
            isCorrect
                ? LinearGradient(
                  colors: [AppColors.green, AppColors.green.withOpacity(0.8)],
                )
                : LinearGradient(colors: [Colors.white, Colors.grey.shade50]),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isCorrect ? AppColors.green : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow:
            isCorrect
                ? [
                  BoxShadow(
                    color: AppColors.green.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ]
                : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isCorrect ? Colors.white : Colors.grey.shade600,
            size: 32.sp,
          ),
          verticalSpace(8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedia(String url) {
    if (url.endsWith(".jpg") || url.endsWith(".png")) {
      return Container(
        height: 200.h,
        width: double.infinity,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.lmcOrange,
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else if (url.endsWith(".mp4") &&
        _videoController?.value.isInitialized == true) {
      return Container(
        height: 200.h,
        child: AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

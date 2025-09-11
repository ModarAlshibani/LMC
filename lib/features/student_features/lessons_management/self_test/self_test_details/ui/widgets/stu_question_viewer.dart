import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';

class StudentQuestionViewer extends StatefulWidget {
  final Questions question;
  final int index;
  final int total;

  /// Fires when the student submits.
  /// String = submitted answer (choice text or "true"/"false")
  /// bool = isCorrect
  final void Function(String submittedAnswer, bool isCorrect)? onSubmitted;

  const StudentQuestionViewer({
    super.key,
    required this.question,
    required this.index,
    required this.total,
    this.onSubmitted,
  });

  @override
  State<StudentQuestionViewer> createState() => _StudentQuestionViewerState();
}

class _StudentQuestionViewerState extends State<StudentQuestionViewer>
    with TickerProviderStateMixin {
  VideoPlayerController? _videoController;
  AnimationController? _slideController;
  AnimationController? _bounceController;
  AnimationController? _pulseController;
  Animation<double>? _slideAnimation;
  Animation<double>? _bounceAnimation;
  Animation<double>? _pulseAnimation;

  // Student state
  int? _selectedChoiceIndex; // for MCQ
  String? _selectedTF; // "true" or "false"
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initMedia();
  }

  /// Reset internal state when a different question/index is provided
  @override
  void didUpdateWidget(covariant StudentQuestionViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    final questionChanged =
        oldWidget.question != widget.question || oldWidget.index != widget.index;

    if (questionChanged) {
      _submitted = false;
      _selectedChoiceIndex = null;
      _selectedTF = null;

      final oldMedia = oldWidget.question.media;
      final newMedia = widget.question.media;
      if (oldMedia != newMedia) {
        _videoController?.dispose();
        _videoController = null;
        _initMedia();
      }

      _slideController?.forward(from: 0);
      _bounceController?.forward(from: 0);
    }
  }

  void _initAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _slideController?.forward();
      _bounceController?.forward();
      _pulseController?.repeat(reverse: true);
    });
  }

  void _initMedia() {
    final media = widget.question.media;
    if (media != null && media.endsWith(".mp4")) {
      _videoController = VideoPlayerController.network(media)
        ..initialize().then((_) {
          if (!mounted) return;
          _videoController?.setLooping(true);
          _videoController?.play();
          setState(() {});
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
      decoration: const BoxDecoration(
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
                    _buildProgressHeader(),
                    verticalSpace(20.h),

                    if (question.media != null)
                      _buildGlassMediaContainer(question.media!),

                    verticalSpace(20.h),

                    _buildQuestionText(question.questionText ?? "-"),

                    verticalSpace(16.h),

                    _buildQuestionTypeBadge((question.type ?? "UNKNOWN")),

                    verticalSpace(24.h),

                    if (question.type == "true_false")
                      _buildInteractiveTrueFalse(question.correctAnswer)
                    else if (question.choices != null &&
                        question.choices!.isNotEmpty)
                      _buildInteractiveChoices(
                        question.choices!,
                        question.correctAnswer,
                      ),

                    verticalSpace(20.h),

                    _buildSubmitBar(),
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
            offset: const Offset(0, 4),
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
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  width: MediaQuery.of(context).size.width *
                      0.85 *
                      ((widget.index + 1) / widget.total),
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
                        offset: const Offset(0, 2),
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
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  _buildMedia(url),
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
                  offset: const Offset(0, 5),
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
                  offset: const Offset(0, 4),
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

  /// Multiple-choice (interactive)
  Widget _buildInteractiveChoices(
    List<String> choices,
    String? correctAnswer,
  ) {
    final normalizedCorrect = correctAnswer?.trim().toLowerCase();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: choices.asMap().entries.map((entry) {
        final index = entry.key;
        final choice = entry.value;
        final isSelected = _selectedChoiceIndex == index;
        final isCorrectAfterSubmit = _submitted &&
            choice.trim().toLowerCase() == normalizedCorrect;

        return GestureDetector(
          onTap: _submitted
              ? null
              : () {
                  setState(() {
                    _selectedChoiceIndex = index;
                  });
                },
          child: AnimatedBuilder(
            animation: _slideAnimation ?? const AlwaysStoppedAnimation(1.0),
            builder: (context, child) {
              final slideValue =
                  (_slideAnimation?.value ?? 1.0).clamp(0.0, 1.0);
              return Transform.translate(
                offset: Offset((1 - slideValue) * 100, 0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: isCorrectAfterSubmit
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
                      color: isCorrectAfterSubmit
                          ? AppColors.green
                          : isSelected
                              ? AppColors.lmcOrange
                              : Colors.grey.shade300,
                      width: 2,
                    ),
                    boxShadow: isCorrectAfterSubmit
                        ? [
                            BoxShadow(
                              color: AppColors.green.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: isCorrectAfterSubmit
                              ? Colors.white
                              : isSelected
                                  ? AppColors.lmcOrange.withOpacity(0.2)
                                  : AppColors.lmcOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: isCorrectAfterSubmit
                              ? Icon(
                                  Iconsax.tick_circle,
                                  color: AppColors.green,
                                  size: 24.sp,
                                )
                              : Text(
                                  String.fromCharCode(65 + index),
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
                            color: isCorrectAfterSubmit
                                ? Colors.white
                                : Colors.grey.shade700,
                            fontWeight: isCorrectAfterSubmit
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  /// True/False (interactive)
  Widget _buildInteractiveTrueFalse(String? correctAnswer) {
    final normalizedCorrect = (correctAnswer ?? "").trim().toLowerCase();
    return AnimatedBuilder(
      animation: _bounceAnimation ?? const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        final bounceValue = (_bounceAnimation?.value ?? 1.0).clamp(0.1, 2.0);
        return Transform.scale(
          scale: bounceValue,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _submitted
                      ? null
                      : () {
                          setState(() {
                            _selectedTF = "true";
                          });
                        },
                  child: _buildTFBlock(
                    label: "True",
                    isCorrectReveal: _submitted && normalizedCorrect == "true",
                    isSelected: _selectedTF == "true",
                    icon: Iconsax.tick_circle,
                  ),
                ),
              ),
              horizontalSpace(16.w),
              Expanded(
                child: GestureDetector(
                  onTap: _submitted
                      ? null
                      : () {
                          setState(() {
                            _selectedTF = "false";
                          });
                        },
                  child: _buildTFBlock(
                    label: "False",
                    isCorrectReveal: _submitted && normalizedCorrect == "false",
                    isSelected: _selectedTF == "false",
                    icon: Iconsax.close_circle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTFBlock({
    required String label,
    required bool isCorrectReveal,
    required bool isSelected,
    required IconData icon,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        gradient: isCorrectReveal
            ? LinearGradient(
                colors: [AppColors.green, AppColors.green.withOpacity(0.8)],
              )
            : LinearGradient(colors: [Colors.white, Colors.grey.shade50]),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isCorrectReveal
              ? AppColors.green
              : isSelected
                  ? AppColors.lmcOrange
                  : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: isCorrectReveal
            ? [
                BoxShadow(
                  color: AppColors.green.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isCorrectReveal ? Colors.white : Colors.grey.shade600,
            size: 32.sp,
          ),
          verticalSpace(8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: isCorrectReveal ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitBar() {
    final q = widget.question;
    final hasSelection = q.type == "true_false"
        ? _selectedTF != null
        : _selectedChoiceIndex != null;

    return AnimatedBuilder(
      animation: _pulseAnimation ?? const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        final pulseValue = (_pulseAnimation?.value ?? 1.0).clamp(0.95, 1.05);
        return Transform.scale(
          scale: _submitted ? 1.0 : pulseValue,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _submitted
                        ? "Answer submitted"
                        : hasSelection
                            ? "Ready to submit?"
                            : "Select an answer to continue",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (!_submitted && hasSelection) ? _handleSubmit : null,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _submitted
                            ? [Colors.grey.shade400, Colors.grey.shade500]
                            : [AppColors.lmcOrange, Colors.deepOrange.shade400],
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: (_submitted ? Colors.grey : AppColors.lmcOrange)
                              .withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _submitted ? Iconsax.tick_circle : Iconsax.send_2,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        horizontalSpace(8.w),
                        Text(
                          _submitted ? "Submitted" : "Submit",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
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

  void _handleSubmit() {
    final q = widget.question;
    String submittedAnswer;
    if (q.type == "true_false") {
      submittedAnswer = (_selectedTF ?? "").trim().toLowerCase();
    } else {
      final idx = _selectedChoiceIndex!;
      submittedAnswer = q.choices![idx];
    }

    final isCorrect = submittedAnswer.trim().toLowerCase() ==
        (q.correctAnswer ?? "").trim().toLowerCase();

    setState(() {
      _submitted = true; // reveal correct answer in green
    });

    widget.onSubmitted?.call(submittedAnswer, isCorrect);
  }

  Widget _buildMedia(String url) {
    if (url.endsWith(".jpg") ||
        url.endsWith(".png") ||
        url.endsWith(".jpeg") ||
        url.endsWith(".webp")) {
      return SizedBox(
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
          errorBuilder: (_, __, ___) => Container(
            height: 200.h,
            alignment: Alignment.center,
            color: Colors.white,
            child: Icon(
              Iconsax.image,
              size: 28.sp,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      );
    } else if (url.endsWith(".mp4") &&
        _videoController?.value.isInitialized == true) {
      return SizedBox(
        height: 200.h,
        child: AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/data/models/lessons_model.dart';

class LessonOutside extends StatefulWidget {
  final Lesson lesson;
  final int index;

  const LessonOutside({
    super.key,
    required this.lesson,
    required this.index,
  });

  @override
  State<LessonOutside> createState() => _LessonOutsideState();
}

class _LessonOutsideState extends State<LessonOutside>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _hoverController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startPulseAnimation();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
  }

  void _startPulseAnimation() {
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) {
        _pulseController.repeat(reverse: true);
      }
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isHovered = true);
    _hoverController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isHovered = false);
    _hoverController.reverse();
    _navigateToLesson();
  }

  void _onTapCancel() {
    setState(() => _isHovered = false);
    _hoverController.reverse();
  }

  void _navigateToLesson() {
    Navigator.pushNamed(
      context,
      Routes.stu_lesson_screen,
      arguments: widget.lesson,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _buildLessonNode(context),
          verticalSpace(20.h),
        ],
      ),
    );
  }

  Widget _buildLessonNode(BuildContext context) {
    bool isLeft = widget.index % 2 == 0;
    double horizontalOffset = isLeft ? -60.w : 60.w;

    return Container(
      width: double.infinity,
      height: 140.h,
      child: Stack(
        children: [
          _buildConnectionLine(context),
          _buildLessonCircle(horizontalOffset, isLeft),
          _buildLessonLabel(horizontalOffset, isLeft),
        ],
      ),
    );
  }

  Widget _buildConnectionLine(BuildContext context) {
    if (widget.index == 0) return const SizedBox.shrink();

    return Positioned(
      left: (MediaQuery.of(context).size.width / 2) - 2.w,
      top: -20.h,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: 4.w,
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.lmcBlue.withOpacity(0.2 + (0.3 * _pulseAnimation.value)),
                  AppColors.lmcBlue.withOpacity(0.4 + (0.2 * _pulseAnimation.value)),
                ],
              ),
              borderRadius: BorderRadius.circular(2.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lmcBlue.withOpacity(0.3 * _pulseAnimation.value),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLessonCircle(double horizontalOffset, bool isLeft) {
    return Center(
      child: Transform.translate(
        offset: Offset(horizontalOffset, 0),
        child: AnimatedBuilder(
          animation: Listenable.merge([_scaleAnimation, _glowAnimation, _pulseAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: GestureDetector(
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                onTapCancel: _onTapCancel,
                child: Container(
                  width: 90.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.lmcBlue,
                        AppColors.lmcBlue.withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lmcBlue.withOpacity(0.4 + (0.2 * _glowAnimation.value)),
                        blurRadius: 16 + (8 * _glowAnimation.value),
                        offset: const Offset(0, 6),
                        spreadRadius: 2 + (2 * _glowAnimation.value),
                      ),
                      BoxShadow(
                        color: AppColors.lmcBlue.withOpacity(0.2 * _pulseAnimation.value),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                        spreadRadius: 4,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: _buildLessonContent(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLessonContent() {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isHovered ? Iconsax.play : Iconsax.book_1,
                color: Colors.white,
                size: 20.sp,
              ),
              SizedBox(height: 2.h),
              Text(
                "${widget.index + 1}",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLessonLabel(double horizontalOffset, bool isLeft) {
    return Center(
      child: Transform.translate(
        offset: Offset(isLeft ? horizontalOffset + 130.w : horizontalOffset - 130.w, 0),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.9 + (0.1 * _scaleAnimation.value),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: AppColors.lmcBlue.withOpacity(0.1 * _glowAnimation.value),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Lesson ${widget.index + 1}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                    if (widget.lesson.title?.isNotEmpty == true) ...[
                      SizedBox(height: 2.h),
                      Text(
                        widget.lesson.title!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: isLeft ? TextAlign.left : TextAlign.right,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
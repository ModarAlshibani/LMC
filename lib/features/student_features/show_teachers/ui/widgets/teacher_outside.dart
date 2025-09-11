import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';

class TeacherOutside extends StatefulWidget {
  final Teachers teacher;

  const TeacherOutside({super.key, required this.teacher});

  @override
  State<TeacherOutside> createState() => _TeacherOutsideState();
}

class _TeacherOutsideState extends State<TeacherOutside>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _shadowAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lmcBlue.withOpacity(0.15 * _shadowAnimation.value),
                  blurRadius: 20 * _shadowAnimation.value,
                  offset: Offset(0, 8 * _shadowAnimation.value),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.08 * _shadowAnimation.value),
                  blurRadius: 15 * _shadowAnimation.value,
                  offset: Offset(0, 4 * _shadowAnimation.value),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.show_teacher_profile,
                  arguments: widget.teacher,
                ),
                onTapDown: (_) => _animationController.forward(),
                onTapUp: (_) => _animationController.reverse(),
                onTapCancel: () => _animationController.reverse(),
                borderRadius: BorderRadius.circular(16.r),
                splashColor: AppColors.lmcOrange.withOpacity(0.2),
                highlightColor: AppColors.lmcBlue.withOpacity(0.1),
                child: Stack(
                  children: [
                    // Main container with enhanced styling
                    Container(
                      width: 145.w,
                      height: 145.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.lmcBlue,
                            AppColors.lmcBlue.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Profile image with enhanced loading and error handling
                            Image.network(
                              widget.teacher.Photo?.replaceAll('localhost', ApiConstants.ip) ?? 
                              'assets/images/LMC-LOGO.png',
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.lmcBlue.withOpacity(0.3),
                                        AppColors.lmcOrange.withOpacity(0.2),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.backgroundColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.lmcBlue,
                                        AppColors.lmcOrange.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person_rounded,
                                          size: 40.sp,
                                          color: AppColors.backgroundColor.withOpacity(0.8),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'LMC',
                                          style: TextStyle(
                                            color: AppColors.backgroundColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            
                            // Subtle overlay gradient for better text readability
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
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

                    // Enhanced glass name container
                    Positioned(
                      bottom: 0,
                      child: GlassContainer(
                        height: 35.h,
                        width: 145.w,
                        bottomLeft: 16,
                        bottomRight: 16,
                        firstColor: AppColors.lmcOrange,
                        secondColor: AppColors.lmcOrange,
                        topLeft: 0,
                        topRight: 0,
                        firstBlurOpacity: 0.4,
                        secondBlurOpacity: 0.35,
                        sigmaX: 100,
                        sigmaY: 100,
                        withBorder: true,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Center(
                            child: Text(
                              "${widget.teacher.name}",
                              style: TextStyle(
                                color: AppColors.backgroundColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                letterSpacing: 0.3,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Subtle shine effect on top
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Interactive indicator (small dot)
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        width: 6.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: AppColors.lmcOrange.withOpacity(0.8),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lmcOrange.withOpacity(0.4),
                              blurRadius: 4,
                              spreadRadius: 1,
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
      },
    );
  }
}
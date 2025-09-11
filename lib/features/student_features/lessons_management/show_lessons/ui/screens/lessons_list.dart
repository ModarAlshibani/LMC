import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/certificates/logic/cubit/view_certificate_cubit.dart';
import 'package:lmc_app/features/student_features/certificates/logic/usecase/view_certificate_usecase.dart';
import 'package:lmc_app/features/student_features/certificates/ui/screens/cirtificate_screen.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/data/models/lessons_model.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/logic/cubit/lessons_cubit.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/logic/cubit/lessons_state.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/ui/widgets/lesson_outside.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_lesson_details/ui/widgets/info_row.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_lesson_details/ui/widgets/selftest_action_button.dart';

class LessonsList extends StatefulWidget {
  final MyCoursesStu course_details;

  const LessonsList({super.key, required this.course_details});

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _listAnimationController;
  late Animation<double> _headerSlideAnimation;
  late Animation<double> _headerFadeAnimation;
  late Animation<double> _listFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _headerSlideAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _listFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _listAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _startAnimations() {
    _headerAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _listAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _listAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAnimatedAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 40.h),
          child: Column(
            children: [
              _buildAnimatedCourseInfoCard(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: SelftestActionButton(
                  context: context,
                  icon: Iconsax.document_text_copy,
                  title: "Final Exam",
                  subtitle: 'Take the course final exam',
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        Routes.stu_get_final_test,
                        arguments: widget.course_details.id,
                      ),
                ),
              ),

              verticalSpace(10.h),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: SelftestActionButton(
                  context: context,
                  icon: Iconsax.document_text_copy,
                  title: "Get Certificate",
                  subtitle: 'Get course certificate after finishing it',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider(
                                create:
                                    (context) => ViewCertificateCubit(
                                      ViewCertificateUsecase(ApiService()),
                                    ),
                                child: CertificateScreen(
                                  courseId: widget.course_details.id!,
                                ),
                              ),
                        ),
                      ),
                ),
              ),
              _buildAnimatedLessonsList(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAnimatedAppBar() {
    return AppBar(
      backgroundColor: AppColors.background2,
      elevation: 0,
      title: AnimatedBuilder(
        animation: _headerFadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _headerFadeAnimation.value,
            child: Text(
              'Course Details',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          );
        },
      ),
      leading: AnimatedBuilder(
        animation: _headerFadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _headerFadeAnimation.value,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedCourseInfoCard() {
    return AnimatedBuilder(
      animation: _headerAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _headerSlideAnimation.value),
          child: Opacity(
            opacity: _headerFadeAnimation.value,
            child: _buildCourseInfoCard(),
          ),
        );
      },
    );
  }

  Widget _buildCourseInfoCard() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1000),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.grey.shade50],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: AppColors.lmcBlue.withOpacity(0.1),
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                      spreadRadius: -8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCourseHeader(),
                    verticalSpace(24),
                    _buildCourseDetails(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseHeader() {
    return Row(
      children: [
        Hero(
          tag: 'course_icon_${widget.course_details.id}',
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.lmcBlue, AppColors.lmcBlue.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lmcBlue.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Iconsax.book_saved_copy,
              color: Colors.white,
              size: 32.sp,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.course_details.language ?? 'Course',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lmcBlue,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Learning Path',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCourseDetails() {
    final details = [
      {
        'icon': Iconsax.note,
        'label': 'Description',
        'value': widget.course_details.description ?? 'Not specified',
      },
      {
        'icon': Iconsax.calendar,
        'label': 'Start Date',
        'value':
            widget.course_details.courseSchedule?[0].startDate ??
            'Not specified',
      },
      {
        'icon': Iconsax.calendar_1_copy,
        'label': 'End Date',
        'value':
            widget.course_details.courseSchedule?[0].endDate ?? 'Not specified',
      },
      {
        'icon': Iconsax.clock,
        'label': 'Time',
        'value':
            '[${widget.course_details.courseSchedule?[0].startTime}] to [${widget.course_details.courseSchedule?[0].endTime}]',
      },
      {
        'icon': Iconsax.calendar_circle,
        'label': 'Days',
        'value':
            widget.course_details.courseSchedule?[0].courseDays?.toString() ??
            'N/A',
      },
    ];

    return Column(
      children:
          details.asMap().entries.map((entry) {
            final index = entry.key;
            final detail = entry.value;

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: index < details.length - 1 ? 16.h : 0,
                      ),
                      child: InfoRow(
                        icon: detail['icon'] as IconData,
                        label: detail['label'] as String,
                        value: detail['value'] as String,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
    );
  }

  Widget _buildAnimatedLessonsList() {
    return AnimatedBuilder(
      animation: _listFadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _listFadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _listFadeAnimation.value)),
            child: _buildLessonsContent(),
          ),
        );
      },
    );
  }

  Widget _buildLessonsContent() {
    return BlocBuilder<LessonsCubit, LessonsState>(
      builder: (context, state) {
        if (state is LessonsLoading) {
          return _buildLoadingState();
        } else if (state is LessonsFailure) {
          return _buildErrorState();
        } else if (state is LessonsSuccess) {
          return _buildSuccessState(state.myLessons.toList());
        }
        return _buildEmptyState();
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 2),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value * 6.28318, // 2π radians
                  child: CircularProgressIndicator(
                    color: AppColors.lmcBlue,
                    strokeWidth: 3,
                  ),
                );
              },
            ),
            verticalSpace(16),
            Text(
              'Loading lessons...',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 48.sp,
                    color: Colors.red.shade400,
                  ),
                ),
                verticalSpace(16),
                Text(
                  'Error loading lessons',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccessState(List<Lesson> lessons) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.lmcBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${lessons.length} Lessons',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lmcBlue,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Iconsax.route_square,
                color: AppColors.lmcBlue.withOpacity(0.7),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Learning Path',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        ...lessons.asMap().entries.map((entry) {
          final index = entry.key;
          final lesson = entry.value;

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: LessonOutside(lesson: lesson, index: index),
                ),
              );
            },
          );
        }).toList(),
        verticalSpace(80),
      ],
    );
  }

  Widget _buildEmptyState() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(40.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.book,
                      size: 48.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  verticalSpace(16),
                  Text(
                    'No lessons found',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    'Check back later for new lessons',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade500,
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
}




  // () => Navigator.pushNamed(
  //                       context,
  //                       Routes.stu_get_final_test,
  //                       arguments: widget.course_details.id,
  //                     ),
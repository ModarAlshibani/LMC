import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/logic/cubit/show_schedule_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/ui/widgets/lessons_list_dialoge.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/ui/widgets/no_lesson_dialoge.dart';

class TeacherCalendarScreen extends StatefulWidget {
  const TeacherCalendarScreen({super.key});

  @override
  State<TeacherCalendarScreen> createState() => _TeacherCalendarScreenState();
}

class _TeacherCalendarScreenState extends State<TeacherCalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  String _formatDateForApi(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });

    // Fetch schedule for selected day
    final dateString = _formatDateForApi(selectedDay);
    context.read<ShowScheduleCubit>().fetchShowSchedule(dateString);
  }

  void _changeMonth(int monthChange) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + monthChange,
      );
    });
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final firstWeekday = firstDay.weekday;

    List<DateTime> days = [];

    // Add empty days for the beginning of the month
    for (int i = 1; i < firstWeekday; i++) {
      days.add(
        DateTime(
          firstDay.year,
          firstDay.month,
          firstDay.day - (firstWeekday - i),
        ),
      );
    }

    // Add all days of the current month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    // Add days to complete the last week
    while (days.length % 7 != 0) {
      final lastDate = days.last;
      days.add(DateTime(lastDate.year, lastDate.month, lastDate.day + 1));
    }

    return days;
  }

  bool _isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  bool _isCurrentMonth(DateTime day) {
    return day.month == _currentMonth.month && day.year == _currentMonth.year;
  }

  String _getMonthName() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return "${months[_currentMonth.month - 1]} ${_currentMonth.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  // Back Button
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

                  // Title Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Teacher",
                          style: TextStyle(
                            color: AppColors.lmcBlue.withOpacity(0.7),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Schedule Calendar",
                          style: TextStyle(
                            color: AppColors.lmcBlue,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Calendar Info Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lmcOrange.withOpacity(0.8),
                    AppColors.lmcBlue.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lmcOrange.withOpacity(0.3),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.calendar_month,
                      color: AppColors.backgroundColor,
                      size: 28.sp,
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Teaching Calendar",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Tap on any date to view your lessons",
                          style: TextStyle(
                            color: AppColors.backgroundColor.withOpacity(0.9),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Calendar Section
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Calendar Header with Month Navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _changeMonth(-1),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.lmcBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: AppColors.lmcBlue,
                              size: 24.sp,
                            ),
                          ),
                        ),

                        Text(
                          _getMonthName(),
                          style: TextStyle(
                            color: AppColors.lmcBlue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        GestureDetector(
                          onTap: () => _changeMonth(1),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.lmcBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: AppColors.lmcBlue,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Days of Week Header
                    Row(
                      children:
                          ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                              .map(
                                (day) => Expanded(
                                  child: Text(
                                    day,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.lmcBlue.withOpacity(0.7),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),

                    SizedBox(height: 16.h),

                    // Calendar Grid
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                        ),
                        itemCount: _getDaysInMonth().length,
                        itemBuilder: (context, index) {
                          final day = _getDaysInMonth()[index];
                          final isSelected = _isSameDay(day, _selectedDay);
                          final isToday = _isSameDay(day, DateTime.now());
                          final isCurrentMonthDay = _isCurrentMonth(day);

                          return GestureDetector(
                            onTap: () => _onDaySelected(day),
                            child: Container(
                              margin: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                gradient:
                                    isSelected
                                        ? LinearGradient(
                                          colors: [
                                            AppColors.lmcOrange,
                                            AppColors.lmcBlue,
                                          ],
                                        )
                                        : null,
                                color:
                                    isSelected
                                        ? null
                                        : isToday
                                        ? AppColors.lmcBlue.withOpacity(0.2)
                                        : null,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  day.day.toString(),
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? AppColors.backgroundColor
                                            : isCurrentMonthDay
                                            ? isToday
                                                ? AppColors.lmcBlue
                                                : AppColors.lmcBlue
                                            : AppColors.lmcBlue.withOpacity(
                                              0.3,
                                            ),
                                    fontSize: 14.sp,
                                    fontWeight:
                                        isSelected || isToday
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // BlocListener for handling API responses
                    BlocListener<ShowScheduleCubit, ShowScheduleState>(
                      listener: (context, state) {
                        if (state is ShowScheduleSuccess) {
                          if (state.schedule.lessons != null &&
                              state.schedule.lessons!.isNotEmpty) {
                            // Show lessons popup dialog
                            showDialog(
                              context: context,
                              builder:
                                  (context) => LessonsPopupDialog(
                                    lessons: state.schedule.lessons!,
                                    selectedDate: _selectedDay,
                                  ),
                            );
                          } else {
                            // Show no lessons dialog
                            showDialog(
                              context: context,
                              builder:
                                  (context) => NoLessonsDialog(
                                    selectedDate: _selectedDay,
                                  ),
                            );
                          }
                        } else if (state is ShowScheduleFailure) {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${state.error}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<ShowScheduleCubit, ShowScheduleState>(
                        builder: (context, state) {
                          if (state is ShowScheduleLoading) {
                            return Container(
                              padding: EdgeInsets.all(20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.lmcOrange,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    "Loading schedule...",
                                    style: TextStyle(
                                      color: AppColors.lmcBlue,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

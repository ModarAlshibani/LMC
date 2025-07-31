import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/get_students_names_cubit.dart';

class HeaderSection extends StatelessWidget {
  final String? lessonDate;
  const HeaderSection({super.key, this.lessonDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: GlassContainer(
        withBorder: true,
        width: double.infinity,
        height: 120.h,
        topLeft: 16.r,
        topRight: 16.r,
        bottomRight: 16.r,
        bottomLeft: 16.r,
        firstColor: AppColors.lightLmcBlue.withOpacity(0.5),
        secondColor: AppColors.lmcOrange.withOpacity(0.01),
        firstBlurOpacity: 0.8,
        secondBlurOpacity: 0.5,
        sigmaX: 80,
        sigmaY: 80,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<GetStudentsNamesCubit, GetStudentsNamesState>(
                builder: (context, state) {
                  String totalStudents = '0';
                  if (state is GetStudentsNamesSuccess) {
                    totalStudents = '${state.getStudentsNames.length}';
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Iconsax.people,
                            size: 28.sp,
                            color: AppColors.lmcOrange,
                          ),
                          verticalSpace(8),
                          Text(
                            totalStudents,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                          verticalSpace(4),
                          Text(
                            'Total Students',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lmcBlue.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Iconsax.calendar_1,
                            size: 28.sp,
                            color: AppColors.lmcOrange,
                          ),
                          verticalSpace(8),
                          Text(
                            formatLessonDate(lessonDate),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                          verticalSpace(4),
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lmcBlue.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatLessonDate(String? lessonDate) {
  if (lessonDate == null || lessonDate.isEmpty) {
    final now = DateTime.now();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${now.day} ${months[now.month - 1]}';
  }
  try {
    final date = DateTime.parse(lessonDate);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  } catch (e) {
    return lessonDate;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class QuestionCard extends StatelessWidget {
  final Questions question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    IconData iconData;
    String label;

    switch (question.type) {
      case "true_false":
        badgeColor = Colors.green;
        iconData = Icons.check_circle;
        label = "True/False";
        break;
      case "translate":
        badgeColor = Colors.deepPurple;
        iconData = Icons.translate;
        label = "Translate";
        break;
      default:
        badgeColor = AppColors.lmcOrange;
        iconData = Icons.help;
        label = question.type ?? "Unknown";
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (question.media != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                question.media!,
                height: 80.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 8.h),
          Text(
            question.questionText ?? "-",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Row(
            children: [
              Icon(iconData, color: badgeColor, size: 20.sp),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(fontSize: 12.sp, color: badgeColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
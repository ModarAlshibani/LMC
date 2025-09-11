import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/theming/colors.dart';

class QuestionTypePicker extends StatefulWidget {
  final Function(String) updateShow;

  QuestionTypePicker({required this.updateShow});

  @override
  State<QuestionTypePicker> createState() => _QuestionTypePickerState();
}

class _QuestionTypePickerState extends State<QuestionTypePicker> {
  String selectedType = "MCQ";

  final Map<String, Map<String, dynamic>> questionTypes = {
    "MCQ": {
      "label": "MCQ",
      "icon": Iconsax.task_square,
      "color": AppColors.lightLmcBlue,
    },
    "True-False": {
      "label": "True/False",
      "icon": Iconsax.shield_tick,
      "color": AppColors.green,
    },
    "Translation": {
      "label": "Translation",
      "icon": Iconsax.translate,
      "color": AppColors.lmcOrange,
    },
  };

  Widget _buildTypeButton(String type, Map<String, dynamic> data) {
    bool isSelected = selectedType == type;
    Color typeColor = data["color"];

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedType = type;
          });
          widget.updateShow(type);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          height: 40.h,
          decoration: BoxDecoration(
            gradient:
                isSelected
                    ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [typeColor, typeColor.withOpacity(0.8)],
                    )
                    : LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.7),
                      ],
                    ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color:
                  isSelected
                      ? typeColor
                      : AppColors.greyBorder.withOpacity(0.2),
              width: isSelected ? 2.5 : 1.5,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: typeColor.withOpacity(0.3),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                        spreadRadius: 0,
                      ),
                    ]
                    : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      ),
                    ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Colors.white.withOpacity(0.2)
                            : typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    data["icon"],
                    color: isSelected ? Colors.white : typeColor,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 5.h),
                Text(
                  data["label"],
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isSelected ? Colors.white : AppColors.lmcBlue,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.lmcBlue, AppColors.lmcBlue.withOpacity(0.8)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Question Type",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Choose the format for your question",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children:
                questionTypes.entries
                    .map((entry) => _buildTypeButton(entry.key, entry.value))
                    .toList(),
          ),
        ],
      ),
    );
  }
}

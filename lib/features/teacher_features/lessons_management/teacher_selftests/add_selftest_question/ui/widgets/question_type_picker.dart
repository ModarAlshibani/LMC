import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class QuestionTypePicker extends StatefulWidget {
  final Function(String) updateShow;

  QuestionTypePicker({required this.updateShow});

  @override
  State<QuestionTypePicker> createState() => _QuestionTypePickerState();
}

class _QuestionTypePickerState extends State<QuestionTypePicker> {
  Color Color1 = AppColors.lmcOrange;
  Color Color2 = AppColors.background2;
  Color Color3 = AppColors.background2;

  void _mcqPressed() {
    setState(() {
      Color1 = AppColors.lmcOrange;
      Color2 = AppColors.background2;
      Color3 = AppColors.background2;

      widget.updateShow("MCQ");
    });
  }

  void _trueFlasePressed() {
    setState(() {
      Color1 = AppColors.background2;
      Color2 = AppColors.lmcOrange;
      Color3 = AppColors.background2;
      widget.updateShow("True-False");
    });
  }

  void _translationPressed() {
    setState(() {
      Color1 = AppColors.background2;
      Color2 = AppColors.background2;
      Color3 = AppColors.lmcOrange;
      widget.updateShow("Translation");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      color: AppColors.lmcBlue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(
            onPressed: () {
              _mcqPressed();
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Color1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "MCQ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: AppColors.lmcBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 2),
          MaterialButton(
            onPressed: () {
              _trueFlasePressed();
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Color2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "True-False",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: AppColors.lmcBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 2),
          MaterialButton(
            onPressed: () {
              _translationPressed();
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Color3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Translation",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: AppColors.lmcBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

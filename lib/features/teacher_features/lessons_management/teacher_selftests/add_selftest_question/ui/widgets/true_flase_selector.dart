import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/theming/colors.dart';

class TrueFalseSelector extends StatefulWidget {
  final String? selectedAnswer;
  final Function(String) onSelected;

  const TrueFalseSelector({
    Key? key,
    required this.selectedAnswer,
    required this.onSelected,
  }) : super(key: key);

  @override
  _TrueFalseSelectorState createState() => _TrueFalseSelectorState();
}

class _TrueFalseSelectorState extends State<TrueFalseSelector> {
  double trueScale = 1;
  double falseScale = 1;

  void triggerAnimation(String answer) {
    widget.onSelected(answer);
    setState(() {
      if (answer == "true") {
        trueScale = 1.1;
        falseScale = 1;
      } else {
        falseScale = 1.1;
        trueScale = 1;
      }
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        trueScale = 1;
        falseScale = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimatedScale(
          scale: trueScale,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: GestureDetector(
            onTap: () => triggerAnimation("true"),
            child: Container(
              width: 130.w,
              height: 130.h,
              decoration: BoxDecoration(
                color:
                    widget.selectedAnswer == "true"
                        ? AppColors.green
                        : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25),
                boxShadow:
                    widget.selectedAnswer == "true"
                        ? [
                          BoxShadow(
                            color: AppColors.green.withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                        : [],
              ),
              child: Center(
                child: Icon(
                  Iconsax.tick_circle,
                  color: Colors.white,
                  size: 70.sp,
                ),
              ),
            ),
          ),
        ),
        AnimatedScale(
          scale: falseScale,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: GestureDetector(
            onTap: () => triggerAnimation("false"),
            child: Container(
              width: 130.w,
              height: 130.h,
              decoration: BoxDecoration(
                color:
                    widget.selectedAnswer == "false"
                        ? AppColors.red
                        : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25),
                boxShadow:
                    widget.selectedAnswer == "false"
                        ? [
                          BoxShadow(
                            color: AppColors.red.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                        : [],
              ),
              child: Center(
                child: Icon(
                  Iconsax.close_circle,
                  color: Colors.white,
                  size: 70.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

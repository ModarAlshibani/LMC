import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';

class ChoiceWidget extends StatefulWidget {
  final String label;
  final ValueChanged<bool> onSelected;
  final TextEditingController controller;

  const ChoiceWidget({
    super.key,
    required this.label,
    required this.onSelected,
    required this.controller,
  });

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        gradient:
            isChecked
                ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lmcOrange.withOpacity(0.08),
                    AppColors.lmcOrange.withOpacity(0.04),
                  ],
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
              isChecked
                  ? AppColors.lmcOrange
                  : AppColors.greyBorder.withOpacity(0.3),
          width: isChecked ? 2 : 1.5,
        ),
        boxShadow:
            isChecked
                ? [
                  BoxShadow(
                    color: AppColors.lmcOrange.withOpacity(0.15),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ]
                : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  ),
                ],
      ),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Row(
          children: [
            // Choice Letter Badge
            Container(
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.only(left: 8.w, right: 12.w),
              decoration: BoxDecoration(
                gradient:
                    isChecked
                        ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.lmcOrange,
                            AppColors.lmcOrange.withOpacity(0.8),
                          ],
                        )
                        : LinearGradient(
                          colors: [
                            AppColors.lmcBlue.withOpacity(0.1),
                            AppColors.lmcBlue.withOpacity(0.05),
                          ],
                        ),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow:
                    isChecked
                        ? [
                          BoxShadow(
                            color: AppColors.lmcOrange.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                        : [],
              ),
              child: Center(
                child: Text(
                  widget.label.split(' ')[1], // Extract letter (A, B, C, D)
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color:
                        isChecked
                            ? Colors.white
                            : AppColors.lmcBlue.withOpacity(0.7),
                  ),
                ),
              ),
            ),

            // Text Field
            Expanded(
              child: GeneralTextFormField(
                controller: widget.controller,
                hintText: "Enter ${widget.label.toLowerCase()}",
                hintTextStyle: TextStyle(
                  color: AppColors.greyBorder.withOpacity(0.8),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                inputTextStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lmcBlue,
                  height: 1.4,
                ),
              ),
            ),

            // Selection Indicator
            Container(
              margin: EdgeInsets.only(right: 12.w, left: 8.w),
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: isChecked ? AppColors.lmcOrange : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color:
                      isChecked
                          ? AppColors.lmcOrange
                          : AppColors.greyBorder.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow:
                    isChecked
                        ? [
                          BoxShadow(
                            color: AppColors.lmcOrange.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                        : [],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    setState(() => isChecked = !isChecked);
                    widget.onSelected(isChecked);
                  },
                  child: Center(
                    child:
                        isChecked
                            ? Icon(
                              Iconsax.tick_circle_copy,
                              color: Colors.white,
                              size: 16.sp,
                            )
                            : Icon(
                              Iconsax.record,
                              color: AppColors.greyBorder.withOpacity(0.5),
                              size: 16.sp,
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

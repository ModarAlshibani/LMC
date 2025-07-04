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
    return Row(
      children: [
        Expanded(
          child: GeneralTextFormField(
            controller: widget.controller,
            hintText: widget.label,
            hintTextStyle: TextStyle(color: AppColors.greyBorder),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBorder, width: 1.4),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lmcOrange, width: 1.4),
              borderRadius: BorderRadius.circular(20.0),
            ),
            inputTextStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.lmcBlue,
            ),
            prefixIcon: Icon(
              Iconsax.record_circle,
              color: AppColors.lmcBlue,
              size: 25.sp,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Transform.scale(
          scale: 2.2,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() => isChecked = value ?? false);
              widget.onSelected(isChecked);
            },
            activeColor: AppColors.lmcOrange,
            side: BorderSide(
              color: AppColors.greyBorder,
              width: 1,
            ), // 🔵 This is it
          ),
        ),
      ],
    );
  }
}

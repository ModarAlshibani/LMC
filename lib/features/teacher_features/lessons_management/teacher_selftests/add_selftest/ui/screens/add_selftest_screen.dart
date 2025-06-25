import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/App_button.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/guest_features/guest_homePage/ui/widgets/top_container.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest/logic/cubit/add_selftest_cubit.dart';

class AddSelfTestScreen extends StatefulWidget {
  final int lessonId;
  const AddSelfTestScreen({Key? key, required this.lessonId}) : super(key: key);

  @override
  State<AddSelfTestScreen> createState() => _AddSelfTestScreenState();
}

class _AddSelfTestScreenState extends State<AddSelfTestScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addSelfTest(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title == null || description == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("title and description can't be empty!")),
      );
      return;
    }

    context.read<AddSelfTestCubit>().AddSelfTests(
      lessonId: widget.lessonId,
      title: title,
      description: description,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSelfTestCubit, AddSelfTestState>(
      listener: (context, state) {
        if (state is AddSelfTestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("SelfTest added successfully"),
              backgroundColor: AppColors.lmcOrange,
            ),
          );
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            Routes.teacher_selftests_screen,
            arguments: widget.lessonId,
          );
        } else if (state is AddSelfTestFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: -110.h,
                left: -30.w,
                right: -30.w,
                child: TopContainer(height: 300.h, border: true),
              ),

              Positioned(
                top: 90.h,
                left: 50.w,
                right: 50.w,
                child: Center(
                  child: Text(
                    "Add Selftest",
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 250.h,
                left: 30.w,
                right: 30.w,
                child: Column(
                  children: [
                    GlassContainer(
                      width: double.infinity,
                      height: 100.h,
                      topLeft: 15,
                      topRight: 15,
                      bottomRight: 15,
                      bottomLeft: 15,
                      firstColor: AppColors.lmcBlue,
                      secondColor: AppColors.lightLmcBlue,
                      firstBlurOpacity: 0.25,
                      secondBlurOpacity: 0.15,
                      withBorder: false,

                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Add teh new SelfTest data:",
                          style: TextStyle(
                            color: AppColors.lmcBlue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(20.h),
                    GeneralTextFormField(
                      hintText: "SelfTest title",
                      hintTextStyle: TextStyle(color: AppColors.greyBorder),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.greyBorder,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lmcOrange,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      inputTextStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.lmcBlue,
                      ),
                      prefixIcon: Icon(
                        Icons.money_outlined,
                        color: AppColors.lmcBlue,
                        size: 25.sp,
                      ),
                      controller: _titleController,
                    ),
                    verticalSpace(20.h),

                    GeneralTextFormField(
                      hintText: "title description",
                      hintTextStyle: TextStyle(color: AppColors.greyBorder),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.greyBorder,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lmcOrange,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      inputTextStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.lmcBlue,
                      ),
                      prefixIcon: Icon(
                        Icons.money_outlined,
                        color: AppColors.lmcBlue,
                        size: 25.sp,
                      ),
                      controller: _descriptionController,
                    ),

                    verticalSpace(20.h),

                    verticalSpace(20.h),
                    if (state is AddSelfTestLoading)
                      CircularProgressIndicator()
                    else
                      AppTextButton(
                        buttonText: "Add SelfTest",
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.background2,
                        ),
                        onPressed: () => _addSelfTest(context),
                        backgroundColor: AppColors.lmcBlue,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

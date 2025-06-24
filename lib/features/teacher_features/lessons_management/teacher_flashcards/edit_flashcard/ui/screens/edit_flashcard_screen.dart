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
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/edit_flashcard/logic/cubit/edit_flashcard_cubit.dart';

class EditFlashcardScreen extends StatefulWidget {
  final int lessonId;
  final int flashcardId;
  final String oldContent;
  final String oldTranslation;
  const EditFlashcardScreen({
    Key? key,
    required this.flashcardId,
    required this.oldContent,
    required this.oldTranslation,
    required this.lessonId,
  }) : super(key: key);

  @override
  State<EditFlashcardScreen> createState() => _EditFlashcardScreenState();
}

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();

  void _editFlashcard(BuildContext context) {
    final content = _contentController.text;
    final translation = _translationController.text;

    if (content == null || translation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Content and Translation can't be empty!")),
      );
      return;
    }

    context.read<EditFlashcardCubit>().EditFlashcard(
      flashcardId: widget.flashcardId,
      content: content,
      translation: translation,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditFlashcardCubit, EditFlashcardState>(
      listener: (context, state) {
        if (state is EditFlashcardSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Flashcard Edited successfully"),
              backgroundColor: AppColors.lmcOrange,
            ),
          );

          Navigator.pushReplacementNamed(
            context,
            Routes.teacher_lessons_flashcards,
            arguments: widget.lessonId,
          );
        } else if (state is EditFlashcardFailure) {
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
                    "Edit Flashcard",
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
                          "Edit the new flashcard data:",
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
                      hintText: widget.oldContent,
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
                      controller: _contentController,
                    ),
                    verticalSpace(20.h),

                    GeneralTextFormField(
                      hintText: widget.oldTranslation,
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
                      controller: _translationController,
                    ),

                    verticalSpace(20.h),

                    verticalSpace(20.h),
                    if (state is EditFlashcardLoading)
                      CircularProgressIndicator()
                    else
                      AppTextButton(
                        buttonText: "Edit Flashcard",
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.background2,
                        ),
                        onPressed: () => _editFlashcard(context),
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

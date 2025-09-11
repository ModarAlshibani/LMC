import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/core/widgets/custom_app_bar.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/add_flashcard/logic/cubit/add_flashcard_cubit.dart';

class AddFlashcardScreen extends StatefulWidget {
  final int lessonId;
  const AddFlashcardScreen({Key? key, required this.lessonId})
    : super(key: key);

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();

  void _addFlashcard(BuildContext context) {
    final content = _contentController.text.trim();
    final translation = _translationController.text.trim();

    if (content.isEmpty || translation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Content and Translation can't be empty!")),
      );
      return;
    }

    context.read<AddFlashcardCubit>().AddFlashcard(
      lessonId: widget.lessonId,
      content: content,
      translation: translation,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFlashcardCubit, AddFlashcardState>(
      listener: (context, state) {
        if (state is AddFlashcardSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Flashcard added successfully"),
              backgroundColor: AppColors.lmcOrange,
            ),
          );
          Navigator.pop(context);
          Navigator.popAndPushNamed(
            context,
            Routes.teacher_lessons_flashcards,
            arguments: widget.lessonId,
          );
        } else if (state is AddFlashcardFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background2,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: "Add Flashcard"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 200.h,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Info section
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: AppColors.lmcBlue.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: AppColors.lmcBlue.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "Add new flashcard data to help students learn better",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lmcBlue,
                                  ),
                                ),
                              ),

                              SizedBox(height: 24.h),

                              Text(
                                "Flashcard Content",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lmcBlue,
                                ),
                              ),
                              SizedBox(height: 16.h),

                              GeneralTextFormField(
                                controller: _contentController,
                                hintText: "Enter flashcard content",
                                hintTextStyle: TextStyle(
                                  color: AppColors.lmcBlue.withOpacity(0.7),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.lmcBlue.withOpacity(0.2),
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.lmcOrange.withOpacity(0.8),
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                inputTextStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.lmcBlue,
                                ),
                                prefixIcon: Icon(
                                  Icons.lightbulb_outline,
                                  color: AppColors.lmcBlue.withOpacity(0.7),
                                  size: 24.sp,
                                ),
                              ),

                              SizedBox(height: 24.h),

                              Text(
                                "Content Translation",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lmcBlue,
                                ),
                              ),
                              SizedBox(height: 16.h),

                              GeneralTextFormField(
                                controller: _translationController,
                                hintText: "Enter content translation",
                                hintTextStyle: TextStyle(
                                  color: AppColors.lmcBlue.withOpacity(0.7),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.lmcBlue.withOpacity(0.2),
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.lmcOrange.withOpacity(0.8),
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                inputTextStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.lmcBlue,
                                ),
                                prefixIcon: Icon(
                                  Icons.translate,
                                  color: AppColors.lmcBlue.withOpacity(0.7),
                                  size: 24.sp,
                                ),
                              ),

                              Spacer(),

                              // Add some bottom padding for keyboard space
                              SizedBox(height: 20.h),

                              // Button or Loading Indicator
                              if (state is AddFlashcardLoading)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.lmcOrange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: AppColors.lmcOrange.withOpacity(
                                        0.3,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.lmcOrange,
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.lmcOrange,
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.lmcOrange.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 12,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: () => _addFlashcard(context),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Add Flashcard",
                                      style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

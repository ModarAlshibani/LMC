import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/adabtive_text_field.dart';
import 'package:lmc_app/core/widgets/custom_app_bar.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/submit_complaints_usecase.dart';

class SubmitComplaintScreen extends StatelessWidget {
  SubmitComplaintScreen({super.key});

  TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Submit Complaint"),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Complaint Subject",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    AdabtiveTextField(
                      controller: subjectController,
                      labelText: "Enter your complaint subject",
                      maxHeight: 250.h,
                      fillColor: AppColors.backgroundColor,
                      labelTextStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lmcBlue.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                      inputTextStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lmcBlue,
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
                    ),

                    Spacer(),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lmcOrange,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lmcOrange.withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          SubmitComplaintUseCase(ApiService()).execute(
                            subject: subjectController.text,
                            context: context,
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.my_complaints,
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          "Submit Complaint",
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
          ],
        ),
      ),
    );
  }
}

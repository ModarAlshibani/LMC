import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_resault_model.dart';
import 'package:lmc_app/features/for_all/roadmap/ui/screens/roadmap_screen.dart';

class TestResultWidget extends StatelessWidget {
  final TestResultModel result;

  const TestResultWidget({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          verticalSpace(20.h),
          
          // Success Icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.tick_circle,
              size: 40.sp,
              color: Colors.green,
            ),
          ),
          
          verticalSpace(20.h),
          
          // Completion Message
          Text(
            'Test Completed!',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lmcBlue,
            ),
          ),
          
          verticalSpace(8.h),
          
          Text(
            'Congratulations on completing your placement test',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.lmcBlue.withOpacity(0.6),
            ),
          ),
          
          verticalSpace(24.h),
          
          // Level Result - Highlighted
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.1),
                  Colors.blue.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.blue.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.award,
                  color: Colors.blue,
                  size: 18.sp,
                ),
                horizontalSpace(8.w),
                Text(
                  'Your Level: ${result.level}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          
          verticalSpace(24.h),
          
          // Score Breakdown Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.lmcBlue.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.chart_success,
                      color: AppColors.lmcBlue,
                      size: 16.sp,
                    ),
                    horizontalSpace(8.w),
                    Text(
                      'Score Breakdown',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                  ],
                ),
                verticalSpace(16.h),
                _buildScoreRow('Total Score', result.totalScore, Colors.blue, isTotal: true),
                _buildScoreRow('Audio Score', result.audioScore, Colors.purple),
                _buildScoreRow('Reading Score', result.readingScore, AppColors.lmcOrange),
                _buildScoreRow('Speaking Score', result.speakingScore, Colors.green),
              ],
            ),
          ),
          
          verticalSpace(32.h),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.lmcBlue.withOpacity(0.3),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lmcBlue,
                      ),
                    ),
                  ),
                ),
              ),
              horizontalSpace(12.w),
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RoadmapScreen(level: 'A,1,1'))
                        ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lmcOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          verticalSpace(20.h),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, int score, Color color, {bool isTotal = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: isTotal ? color.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: isTotal ? Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14.sp : 13.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: AppColors.lmcBlue.withOpacity(0.8),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              score.toString(),
              style: TextStyle(
                fontSize: isTotal ? 14.sp : 13.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
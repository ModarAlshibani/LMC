import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_question_model.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionModel question;
  final int? selectedAnswerId;
  final Function(int) onAnswerSelected;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.selectedAnswerId,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Context Section (Dynamic height, max 10 lines)
          if (question.context.isNotEmpty) ...[
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.document_text_1,
                        size: 16.sp,
                        color: AppColors.lmcBlue,
                      ),
                      horizontalSpace(8.w),
                      Text(
                        'Context',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lmcBlue,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(12.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final textStyle = TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lmcBlue.withOpacity(0.8),
                        height: 1.4,
                      );
                      
                      final textPainter = TextPainter(
                        text: TextSpan(text: question.context, style: textStyle),
                        textDirection: TextDirection.ltr,
                        maxLines: null,
                      )..layout(maxWidth: constraints.maxWidth);
                      
                      final numberOfLines = (textPainter.height / textPainter.preferredLineHeight).ceil();
                      final maxLines = 10;
                      final shouldScroll = numberOfLines > maxLines;
                      
                      return Container(
                        constraints: shouldScroll ? BoxConstraints(
                          maxHeight: (textStyle.height ?? 1.4) * (textStyle.fontSize ?? 13.sp) * maxLines,
                        ) : null,
                        child: shouldScroll
                            ? SingleChildScrollView(
                                child: Text(question.context, style: textStyle),
                              )
                            : Text(question.context, style: textStyle),
                      );
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(16.h),
          ],

          // Question Text Section (Dynamic height, max 10 lines)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.lmcOrange.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.lmcOrange.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.message_question,
                      size: 16.sp,
                      color: AppColors.lmcOrange,
                    ),
                    horizontalSpace(8.w),
                    Text(
                      'Question',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lmcOrange,
                      ),
                    ),
                  ],
                ),
                verticalSpace(12.h),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final textStyle = TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lmcBlue,
                      height: 1.4,
                    );
                    
                    final textPainter = TextPainter(
                      text: TextSpan(text: question.questionText, style: textStyle),
                      textDirection: TextDirection.ltr,
                      maxLines: null,
                    )..layout(maxWidth: constraints.maxWidth);
                    
                    final numberOfLines = (textPainter.height / textPainter.preferredLineHeight).ceil();
                    final maxLines = 10;
                    final shouldScroll = numberOfLines > maxLines;
                    
                    return Container(
                      constraints: shouldScroll ? BoxConstraints(
                        maxHeight: (textStyle.height ?? 1.4) * (textStyle.fontSize ?? 14.sp) * maxLines,
                      ) : null,
                      child: shouldScroll
                          ? SingleChildScrollView(
                              child: Text(question.questionText, style: textStyle),
                            )
                          : Text(question.questionText, style: textStyle),
                    );
                  },
                ),
              ],
            ),
          ),
          
          verticalSpace(20.h),

          // Answer Options Header
          Text(
            'Select your answer:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.lmcBlue.withOpacity(0.7),
            ),
          ),
          
          verticalSpace(12.h),

          // Answer Options
          ...question.answers.asMap().entries.map((entry) {
            final index = entry.key;
            final answer = entry.value;
            return _buildAnswerOption(answer, index);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(answer, int index) {
    final isSelected = selectedAnswerId == answer.id;
    final optionLetter = String.fromCharCode(65 + index); // A, B, C, D...
    
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: () => onAnswerSelected(answer.id),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppColors.lmcOrange.withOpacity(0.08)
                : AppColors.backgroundColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected 
                  ? AppColors.lmcOrange.withOpacity(0.3)
                  : AppColors.lmcBlue.withOpacity(0.1),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              // Option Letter Circle
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.lmcOrange
                      : AppColors.lmcBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isSelected
                      ? Icon(
                          Iconsax.tick_circle,
                          size: 14.sp,
                          color: Colors.white,
                        )
                      : Text(
                          optionLetter,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lmcBlue,
                          ),
                        ),
                ),
              ),

              horizontalSpace(12.w),

              // Answer Text
              Expanded(
                child: Text(
                  answer.answerText,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected 
                        ? AppColors.lmcOrange 
                        : AppColors.lmcBlue.withOpacity(0.8),
                    height: 1.3,
                  ),
                ),
              ),

              // Selected Indicator
              if (isSelected)
                Icon(
                  Iconsax.tick_square,
                  size: 14.sp,
                  color: AppColors.lmcOrange,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
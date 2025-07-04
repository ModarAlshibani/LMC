import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/screens/mcq_question_form.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/screens/translation_question_form.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/screens/true_false_question_form.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/question_type_picker.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';

class AddSelftestQuestionScreen extends StatefulWidget {
  final SelfTests selfTest;
  const AddSelftestQuestionScreen({super.key, required this.selfTest});

  @override
  State<AddSelftestQuestionScreen> createState() =>
      _AddSelftestQuestionScreenState();
}

class _AddSelftestQuestionScreenState extends State<AddSelftestQuestionScreen> {
  String selectedType = "MCQ"; // Default selection

  Widget _getSelectedWidget() {
    switch (selectedType) {
      case "MCQ":
        return McqQuestionForm(selfTest: widget.selfTest);
      case "True-False":
        return TrueFalseQuestionForm(selfTest: widget.selfTest);
      case "Translation":
        return TranslationQuestionForm(selfTest: widget.selfTest);
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lmcBlue,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 20.w),
              width: double.infinity,
              height: 40.h,
              color: AppColors.lmcBlue,
              child: Text(
                "Question type:",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.background2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            QuestionTypePicker(
              updateShow: (type) {
                setState(() {
                  selectedType = type;
                });
              },
            ),

            Expanded(child: _getSelectedWidget()),
          ],
        ),
      ),
    );
  }
}

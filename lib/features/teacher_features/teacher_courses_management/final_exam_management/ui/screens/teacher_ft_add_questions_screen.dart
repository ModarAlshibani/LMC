// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/widgets/question_type_picker.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/screens/teacher_ft_mcq_question_form.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/screens/teacher_ft_translation_question_form.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/screens/teacher_ft_true_false_question_form.dart';

class AddSelftestQuestionScreenFT extends StatefulWidget {
  final int testId;
  const AddSelftestQuestionScreenFT({
    Key? key,
    required this.testId,
  }) : super(key: key);

  @override
  State<AddSelftestQuestionScreenFT> createState() =>
      _AddSelftestQuestionScreenFTState();
}

class _AddSelftestQuestionScreenFTState extends State<AddSelftestQuestionScreenFT> {
  String selectedType = "MCQ";

  Widget _getSelectedWidget() {
    switch (selectedType) {
      case "MCQ":
        return McqQuestionFormFT(testId: widget.testId);
      case "True-False":
        return TrueFalseQuestionFormFT(testId: widget.testId);
      case "Translation":
        return TranslationQuestionFormFT(testId: widget.testId);
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

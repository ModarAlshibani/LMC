import 'package:flutter/material.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart';

class StudentMyCourseDetails extends StatelessWidget{
  
    final MyCoursesStu course;

  const StudentMyCourseDetails({super.key, required this.course});
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(course.photo ?? 'assets/images/LMC-LOGO.png'),
          ),
           Text(course.level ?? 'cccc'),
           Text(course.teacherName?? 'jjjjjj'),
           Text(course.description?? ''),
           InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.lessons_list, arguments: course.id,),
            child: Container(
              color: AppColors.lmcOrange,
              height: 100,
              width: 100,
            ),
           ),
    
        ],
      ),
    );
  }

}

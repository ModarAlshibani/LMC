import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';

class TeacherOutside extends StatelessWidget {
  final Teachers teacher;

  const TeacherOutside({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.show_teacher_profile, arguments: teacher,),
      child: Stack(
        children: [
          Container(
                    width: 145.w,
                    height: 145.h,
                    decoration: BoxDecoration(
                      color: AppColors.lmcBlue,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(teacher.Photo?.replaceAll('localhost', ApiConstants.ip) ?? 'assets/images/LMC-LOGO.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox.shrink(),
                  ),
          Positioned(
            bottom: 0,
            child: GlassContainer(
              height: 30.h,
              width: 145,
              bottomLeft: 10,
              bottomRight: 10,
              firstColor: AppColors.lmcOrange,
              secondColor: AppColors.lmcOrange,
              topLeft: 0,
              topRight: 0,
              firstBlurOpacity: 0.3,
              secondBlurOpacity: 0.25,
              sigmaX: 100,
              sigmaY: 100,
              withBorder: false,
              child: Center(
                child: Text(
                  "${teacher.name}",
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            
            ),
          ),        
        ],
      ),
    );
  }
}


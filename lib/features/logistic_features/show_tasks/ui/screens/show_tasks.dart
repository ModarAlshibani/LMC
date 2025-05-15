import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/guest_features/guest_homePage/ui/widgets/top_container.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/ui/widgets/tasks_list.dart';

class ShowTasks extends StatelessWidget {
  const ShowTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: Stack(
        children: [
          Positioned(
            top: -110.h,
            left: -30,
            right: -30,
            child: TopContainer(height: 300.h, border: true),
          ),

          Positioned(
            top: 90,
            left: 50,
            right: 50,
            child: Center(
              child: Text(
                "My Tasks",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          Positioned(
            top: 220.h,
            right: 30.w,
            left: 30.w,
            bottom: 20,
            child: TasksList(),
          ),
        ],
      ),
    );
  }
}

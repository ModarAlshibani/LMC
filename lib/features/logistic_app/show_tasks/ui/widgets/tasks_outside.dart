import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';

class TasksOutside extends StatelessWidget {
  const TasksOutside({
    super.key,
    this.taskId,
    this.content,
    this.status,
    this.deadline,
  });
  final String? taskId;
  final String? status;
  final String? deadline;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showTaskDetails(context, taskId!, content!),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: GlassContainer(
          width: double.infinity,
          height: 140.h,
          topLeft: 10,
          topRight: 10,
          bottomRight: 10,
          bottomLeft: 10,
          firstColor: AppColors.lmcBlue,
          secondColor: AppColors.lmcBlue,
          firstBlurOpacity: 0.3,
          secondBlurOpacity: 0.25,
          child: Row(
            children: [
              Container(
                width: 130.w,
                height: 130.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/images/LMC-LOGO.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox.shrink(),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.h,
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        "Task id: $taskId",
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Container(
                      height: 20.h,
                      margin: EdgeInsets.only(top: 4.h),
                      child: Text(
                        "Status: $status",
                        style: TextStyle(
                          color:
                              status == "Pending"
                                  ? const Color.fromARGB(255, 183, 85, 0)
                                  : AppColors.lmcBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Container(
                      height: 20.h,
                      margin: EdgeInsets.only(top: 4.h),
                      child: Text(
                        "Deadline: $deadline",
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        content!,
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(10.w),
            ],
          ),
        ),
      ),
    );
  }
}

void _showTaskDetails(BuildContext context, String taskId, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: GlassContainer(
          width: 350.w,
          height: 430.h,
          topLeft: 15,
          topRight: 15,
          bottomRight: 15,
          bottomLeft: 15,
          firstColor: AppColors.lmcOrange,
          secondColor: AppColors.lmcBlue,
          firstBlurOpacity: 0.25,
          secondBlurOpacity: 0.55,
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Container(
                //   width: 330.w,
                //   height: 200.h,

                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     image: DecorationImage(
                //       image: NetworkImage(image),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                SizedBox(height: 5.h),
                Text(
                  taskId,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Container(
                  height: 85.h,
                  child: SingleChildScrollView(
                    child: Text(
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      content,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                verticalSpace(10.h),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق الـ Dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lmcOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 80.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

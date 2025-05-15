import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';

class TasksOutside extends StatelessWidget {
  const TasksOutside({
    super.key,
    this.id,
    this.creatorId,
    this.description,
    this.status,
    this.deadline,
    this.requiresInvoice,
  });

  final int? id;
  final int? creatorId;
  final String? description;
  final String? status;
  final String? deadline;
  final int? requiresInvoice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => _showTaskDetails(
            context,
            id.toString(),
            description!,
            deadline!,
            status!,
            requiresInvoice!,
          ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lmcBlue,
          // image: DecorationImage(
          //   image: AssetImage("assets/images/container.png"),
          // ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: GlassContainer(
          width: double.infinity,
          height: 120.h,
          topLeft: 10,
          topRight: 10,
          bottomRight: 10,
          bottomLeft: 10,
          firstColor: AppColors.lightLmcBlue,
          secondColor: AppColors.lightLmcBlue,
          firstBlurOpacity: 1,
          secondBlurOpacity: 0.9,
          withBorder: false,
          sigmaX: 100,
          sigmaY: 100,
          child: Row(
            children: [
              horizontalSpace(10.w),
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/images/LMC-LOGO.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox.shrink(),
              ),
              horizontalSpace(10.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.h,
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        "Task id: $id",
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 18,
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
                                  ? const Color.fromARGB(255, 233, 142, 63)
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
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 10.h, top: 4.h),
                      child: Text(
                        description!,
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
              horizontalSpace(20.w),
            ],
          ),
        ),
      ),
    );
  }
}

void _showTaskDetails(
  BuildContext context,
  String taskId,
  String content,
  String deadline,
  String status,
  int requireInvoice,
) {
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
          firstColor: AppColors.lightLmcBlue,
          secondColor: AppColors.lightLmcBlue,
          firstBlurOpacity: 0.45,
          secondBlurOpacity: 0.35,
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage("assets/images/LMC-LOGO.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Task id: $taskId",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.h),
                Text(
                  "Task status: $status",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.h),
                Text(
                  "Deadline: $deadline",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.h),
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

                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // إغلاق الـ Dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background2,
                        minimumSize: Size(200.w, 40.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Ok",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.lmcBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (status != "Done") {
                          Navigator.of(context).pop();
                          _confirm(taskId, context);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            status != "Done"
                                ? AppColors.lmcOrange
                                : AppColors.greyBorder,
                        minimumSize: Size(200.w, 40.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        requireInvoice == 1 && status != "Done"  ? "Send invoice" : "Mark as done",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.background2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _confirm(String taskId, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: GlassContainer(
          width: 350.w,
          height: 230.h,
          topLeft: 15,
          topRight: 15,
          bottomRight: 15,
          bottomLeft: 15,
          firstColor: AppColors.lightLmcBlue,
          secondColor: AppColors.lightLmcBlue,
          firstBlurOpacity: 0.45,
          secondBlurOpacity: 0.35,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Are you sure you want to mark this task as done ?",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    ApiService().markTaskAsDone(int.parse(taskId), context);
                    Navigator.pushNamed(context, '/show_tasks');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lmcOrange,
                    minimumSize: Size(200.w, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    
                    "mark as done",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.background2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background2,
                    minimumSize: Size(200.w, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.lmcBlue,
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

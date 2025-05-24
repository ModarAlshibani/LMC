import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/general_text_form_field.dart';
import '../../../../for_all/announsments/ui/widgets/announcements_list.dart';
import '../../../../guest_features/guest_homePage/ui/widgets/glass_inkwell.dart';
import '../../../../guest_features/guest_homePage/ui/widgets/top_container.dart';

class LogisticHomepage extends StatefulWidget {
  const LogisticHomepage({super.key});

  @override
  State<LogisticHomepage> createState() => _LogisticHomepageState();
}


class _LogisticHomepageState extends State<LogisticHomepage> {

  @override
  void initState() {
    super.initState();
    printDeviceToken(); // ✅ This prints the token when the screen loads
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -30,
              left: -140,
              right: -140,
              child: TopContainer(height: 360.h, border: true),
            ),
            Positioned(
              top: 20.h,
              left: 10.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "Hi Logistic",
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        horizontalSpace(150.w),
                        Icon(
                          Icons.circle_notifications_outlined,
                          size: 50,
                          color: AppColors.backgroundColor,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "LMC !",
                    style: TextStyle(
                      fontSize: 60.sp,
                      color: AppColors.lmcOrange,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 210.h,
              left: 30,
              right: 30,
              child: GeneralTextFormField(
                fillColor: AppColors.backgroundColor,
                hintText: "Search",
                hintTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lmcBlue,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: AppColors.lmcBlue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lmcOrange.withOpacity(0.6),
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              top: 300.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                width: 360.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap:
                          () => Navigator.pushNamed(context, Routes.show_tasks),
                      child: GlassInkwell(
                        firstRow: 'Show',
                        secondRow: 'my',
                        thirdRow: 'tasks',
                        icon: 'assets/icons/task.png',
                      ),
                    ),
                    InkWell(
                      onTap:
                          () => Navigator.pushNamed(context, Routes.done_tasks),
                      child: GlassInkwell(
                        firstRow: 'Show',
                        secondRow: 'done',
                        thirdRow: 'Tasks',
                        icon: 'assets/icons/invoice.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 470,
              left: 30,
              child: Text(
                "Announcments :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lmcBlue,
                ),
              ),
            ),
            Positioned(
              top: 500,
              left: 30,
              right: 30,
              child: Container(height: 320, child: AnnouncementsList()),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> printDeviceToken() async {
  try {
    await FirebaseMessaging.instance.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('📱 Device FCM Token: $token');
    } else {
      print('❌ Failed to get FCM token');
    }
  } catch (e) {
    print('⚠️ Error getting FCM token: $e');
  }
}

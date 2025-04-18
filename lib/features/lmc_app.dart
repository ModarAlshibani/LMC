import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/app_router.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';

class LmcApp extends StatelessWidget {
  final AppRouter appRouter;
  const LmcApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LMC App',
        theme: ThemeData(
          primaryColor: AppColors.lmcBlue,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: 'Poppins',
        ),

        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.onboardingScreen,
      ),
    );
  }
}
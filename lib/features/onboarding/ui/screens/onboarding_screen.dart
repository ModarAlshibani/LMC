import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/onboarding/ui/widgets/fading.dart';
import 'package:lmc_app/features/onboarding/ui/widgets/logo.dart';
import 'package:lmc_app/features/onboarding/ui/widgets/onboarding_text.dart';
import 'package:lmc_app/features/onboarding/ui/widgets/get_started_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Fading(),
            Positioned(
              top: -20.h,
              left: 20.w,
              right: 20.w,
              // right: 40.h,
              child: Center(child: Logo()),
            ),

            Container(
              child: Positioned(
                top: 150.h,
                left: 20.w,
                right: 20.w,
                child: OnboardingText(),
              ),
            ),
            Positioned(
              bottom: 40.h,
              left: 20.w,
              right: 20.w,
              child: GetStartedButton(),
            ),
          ],
        ),
      ),
    );
  }
}

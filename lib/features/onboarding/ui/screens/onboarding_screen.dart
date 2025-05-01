import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/fading.dart';
import '../widgets/get_started_button.dart';
import '../widgets/logo.dart';
import '../widgets/onboarding_text.dart';

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

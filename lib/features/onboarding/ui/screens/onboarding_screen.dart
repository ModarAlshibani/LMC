import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/features/onboarding/ui/widgets/fading.dart';
import 'package:lmc_app/features/onboarding/ui/widgets/name_and_logo.dart';
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
            Positioned(bottom: 0.h, left: 0, right: 0, child: Fading()),
            // Text and other content
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: const NameAndLogo()),
                    SizedBox(height: 200.h),
                    const OnboardingText(),
                    SizedBox(height: 20.h),
                    Center(child: GetStartedButton()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

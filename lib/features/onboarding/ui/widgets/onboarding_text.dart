import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Learn\nMaster\nCommunicate",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

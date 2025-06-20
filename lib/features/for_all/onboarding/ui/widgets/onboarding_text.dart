import 'package:flutter/material.dart';

import '../../../../../core/theming/colors.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Learn,",
            style: TextStyle(
              fontSize: 50,
              color: AppColors.lmcBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Master,",
            style: TextStyle(
              fontSize: 50,
              color: AppColors.lmcBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Communicate",
            style: TextStyle(
              fontSize: 50,
              color: AppColors.lmcOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

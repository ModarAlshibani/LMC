import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class LoginBackgroung extends StatelessWidget {
  const LoginBackgroung({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/b.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.lmcBlue.withOpacity(0.5),
        ),
      ],
    );
  }
}

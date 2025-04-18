import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class NameAndLogo extends StatelessWidget {
  const NameAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: const DecorationImage(
              image: AssetImage('assets/images/logo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'LMC',
          style: TextStyle(
            fontSize: 90,
            fontWeight: FontWeight.bold,
            color: AppColors.lmcBlue,
          ),
        ),
      ],
    );
  }
}

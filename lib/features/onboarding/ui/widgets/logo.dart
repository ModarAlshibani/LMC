import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: const DecorationImage(
          image: AssetImage('assets/images/logo.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

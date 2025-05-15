import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: const DecorationImage(
          image: AssetImage('assets/images/LMC-LOGO.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'dart:ui'; // Import for BackdropFilter

import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';
// import 'package:rive/rive.dart'; // Import the Rive package

class Fading extends StatelessWidget {
  const Fading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Rive animation as the background
        // const RiveAnimation.asset(
        //   'assets/animations/shapes.riv', // Path to your Rive file
        //   fit:
        //       BoxFit.cover, // Ensures the animation covers the entire container
        // ),

        // Blurry white overlay
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 100.0,
            sigmaY: 100.0,
          ), // Adjust blur intensity
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.backgroundColor.withOpacity(
              0.3,
            ), // Semi-transparent white
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../theming/colors.dart';

class Background extends StatelessWidget {
  String? image;
  Color? color;
   Background({super.key, this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: color!,
        ),
      ],
    );
  }
}

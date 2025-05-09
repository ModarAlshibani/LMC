import 'package:flutter/material.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/glass_card.dart';

class GlassInkwell extends StatelessWidget {
  const GlassInkwell({
    super.key,
    required this.firstRow,
    required this.secondRow,
    required this.thirdRow,
    required this.icon,
  });

  final String firstRow;
  final String secondRow;
  final String thirdRow;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GlassContainer(
            width: 90,
            height: 90,
            topLeft: 15,
            topRight: 15,
            bottomRight: 15,
            bottomLeft: 15,
            firstColor: const Color.fromARGB(255, 228, 228, 228),
            secondColor: const Color.fromARGB(255, 228, 228, 228),
            firstBlurOpacity: 1.00,
            secondBlurOpacity: 0.2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    firstRow,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: AppColors.lmcBlue,
                    ),
                  ),
                  Text(
                    secondRow,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: AppColors.lmcBlue,
                    ),
                  ),
                  Text(
                    thirdRow,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: AppColors.lmcBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -16,
            child: Image.asset(icon, height: 45, width: 45),
          ),
        ],
      ),
    );
  }
}

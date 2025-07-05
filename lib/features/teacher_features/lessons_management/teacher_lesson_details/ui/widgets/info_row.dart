import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.lmcOrange, size: 20),
        SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.lmcBlue,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(221, 21, 21, 21),
            ),
          ),
        ),
      ],
    );
  }
}

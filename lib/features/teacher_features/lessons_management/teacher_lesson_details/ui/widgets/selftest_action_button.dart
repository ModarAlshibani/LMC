import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';

class SelftestActionButton extends StatelessWidget {
  final BuildContext context;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SelftestActionButton({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: GlassContainer(
        withBorder: true,
        width: double.infinity,
        height: 90.h,
        topLeft: 16.r,
        topRight: 16.r,
        bottomRight: 16.r,
        bottomLeft: 16.r,
        firstColor: AppColors.lightLmcBlue.withOpacity(0.06),
        secondColor: AppColors.lightLmcBlue.withOpacity(0.05),
        firstBlurOpacity: 0.8,
        secondBlurOpacity: 0.5,
        sigmaX: 80,
        sigmaY: 80,

        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.lmcBlue.withOpacity(0.8),
                      AppColors.lmcBlue.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lmcBlue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: AppColors.background2, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

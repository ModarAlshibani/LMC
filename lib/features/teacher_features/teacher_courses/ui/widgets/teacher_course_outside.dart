import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';

class AnnouncementOutside extends StatelessWidget {
  const AnnouncementOutside({super.key, this.level, this.image, this.description});
  final String? level;
  final String? image;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("course $level pressed");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: GlassContainer(
          withBorder: false,
          width: double.infinity,
          height: 140.h,
          topLeft: 10,
          topRight: 10,
          bottomRight: 10,
          bottomLeft: 10,
          firstColor: AppColors.lmcBlue,
          secondColor: AppColors.lmcBlue,
          firstBlurOpacity: 0.3,
          secondBlurOpacity: 0.25,
          sigmaX: 100,
          sigmaY: 100,
          child: Row(
            children: [
              horizontalSpace(10.w),
              Container(
                width: 130.w,
                height: 130.h,
                decoration: BoxDecoration(
                  color: AppColors.lmcBlue,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(image!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox.shrink(),
              ),
              horizontalSpace(20.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        level!,
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        description!,
                        style: TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(10.w),
            ],
          ),
        ),
      ),
    );
  }
}

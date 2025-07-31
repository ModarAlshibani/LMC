import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/glass_card.dart';

class AnnouncementOutside extends StatelessWidget {
  const AnnouncementOutside({super.key, this.title, this.image, this.content});
  final String? title;
  final String? image;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDialog(context, image!, title!, content!),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        child: Stack(
          children: [
            // Main card
            GlassContainer(
              withBorder: false,
              width: double.infinity,
              height: 160.h,
              topLeft: 16,
              topRight: 16,
              bottomRight: 16,
              bottomLeft: 16,
              firstColor: AppColors.lmcBlue,
              secondColor: AppColors.lmcBlue,
              firstBlurOpacity: 0.15,
              secondBlurOpacity: 0.1,
              sigmaX: 120,
              sigmaY: 120,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.lmcBlue.withOpacity(0.1),
                      AppColors.lmcBlue.withOpacity(0.05),
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.lmcBlue.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    horizontalSpace(16.w),
                    // Enhanced image container
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lmcBlue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            // Background placeholder
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: AppColors.lmcBlue.withOpacity(0.1),
                              child: Icon(
                                Icons.image,
                                color: AppColors.lmcBlue.withOpacity(0.3),
                                size: 40.sp,
                              ),
                            ),
                            // Network image
                            Image.network(
                              image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.lmcBlue,
                                    ),
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.lmcBlue.withOpacity(0.1),
                                  child: Icon(
                                    Icons.broken_image,
                                    color: AppColors.lmcBlue.withOpacity(0.5),
                                    size: 40.sp,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(16.w),
                    // Content section
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with better styling
                            Text(
                              title!,
                              style: TextStyle(
                                color: AppColors.lmcBlue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpace(8.h),
                            // Content preview
                            Text(
                              content!,
                              style: TextStyle(
                                color: AppColors.lmcBlue.withOpacity(0.8),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            // Read more indicator
                            Row(
                              children: [
                                Text(
                                  'Tap to read more',
                                  style: TextStyle(
                                    color: AppColors.lmcBlue.withOpacity(0.6),
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                horizontalSpace(4.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.sp,
                                  color: AppColors.lmcBlue.withOpacity(0.6),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(16.w),
                  ],
                ),
              ),
            ),
            // Notification badge (optional)
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppColors.lmcOrange,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lmcOrange.withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDialog(
  BuildContext context,
  String image,
  String title,
  String content,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: GlassContainer(
          width: 350.w,
          height: 500.h,
          topLeft: 20,
          topRight: 20,
          bottomRight: 20,
          bottomLeft: 20,
          firstColor: AppColors.lmcOrange,
          secondColor: AppColors.lmcBlue,
          firstBlurOpacity: 0.2,
          secondBlurOpacity: 0.4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.lmcOrange.withOpacity(0.1),
                  AppColors.lmcBlue.withOpacity(0.1),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(10.h),
                  // Enhanced image
                  Container(
                    width: 300.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.withOpacity(0.3),
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white.withOpacity(0.5),
                              size: 60.sp,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  verticalSpace(20.h),
                  // Enhanced title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(16.h),
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.6,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  verticalSpace(20.h),
                  // Enhanced button
                  Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.lmcOrange,
                          AppColors.lmcOrange.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lmcOrange.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        "Got it!",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

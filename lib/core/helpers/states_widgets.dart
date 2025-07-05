import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class StateWidgets {
  
  /// Creates a customizable empty state widget
  static Widget buildEmptyState({
    IconData? icon,
    String? title,
    String? subtitle,
    Color? primaryColor,
    Color? secondaryColor,
    double? iconSize,
    double? titleSize,
    double? subtitleSize,
    bool showDecorations = true,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container with gradient background
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (primaryColor ?? AppColors.lmcBlue).withOpacity(0.2),
                  (secondaryColor ?? AppColors.lmcOrange).withOpacity(0.2),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (primaryColor ?? AppColors.lmcBlue).withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              icon ?? Icons.inbox_outlined,
              size: iconSize ?? 60.sp,
              color: (primaryColor ?? AppColors.lmcBlue).withOpacity(0.7),
            ),
          ),

          SizedBox(height: 30.h),

          // Main message
          Text(
            title ?? "No Data Available",
            style: TextStyle(
              fontSize: titleSize ?? 26.sp,
              fontWeight: FontWeight.w700,
              color: primaryColor ?? AppColors.lmcBlue,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // Subtitle message
          if (subtitle != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: subtitleSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: (primaryColor ?? AppColors.lmcBlue).withOpacity(0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30.h),
          ],

          // Decorative elements
          if (showDecorations) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot((primaryColor ?? AppColors.lmcBlue).withOpacity(0.3)),
                SizedBox(width: 8.w),
                _buildDot((secondaryColor ?? AppColors.lmcOrange).withOpacity(0.5)),
                SizedBox(width: 8.w),
                _buildDot((primaryColor ?? AppColors.lmcBlue).withOpacity(0.3)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Creates a customizable error state widget
  static Widget buildErrorState({
    String? title,
    String? subtitle,
    IconData? icon,
    Color? iconColor,
    Color? titleColor,
    Color? subtitleColor,
    double? iconSize,
    double? titleSize,
    double? subtitleSize,
    VoidCallback? onRetry,
    String? retryButtonText,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error icon container
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: (iconColor ?? Colors.redAccent).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.error_outline,
              size: iconSize ?? 50.sp,
              color: (iconColor ?? Colors.redAccent).withOpacity(0.8),
            ),
          ),

          SizedBox(height: 20.h),

          Text(
            title ?? "Something went wrong",
            style: TextStyle(
              fontSize: titleSize ?? 22.sp,
              fontWeight: FontWeight.w600,
              color: titleColor ?? AppColors.lmcBlue,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          if (subtitle != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: subtitleSize ?? 14.sp,
                  fontWeight: FontWeight.w400,
                  color: (subtitleColor ?? AppColors.lmcBlue).withOpacity(0.6),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],

          // Retry button if callback provided
          if (onRetry != null) ...[
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lmcBlue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                retryButtonText ?? "Try Again",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Creates a customizable loading state widget with LMC branding
  static Widget buildLoadingState({
    Color? primaryColor,
    Color? accentColor,
    double? size,
    String? message,
    double? messageSize,
    Color? messageColor,
    TextStyle? textStyle,
  }) {
    return Center(
      child: LMCLoadingIndicator(
        size: size ?? 100.w,
        primaryColor: primaryColor ?? AppColors.lmcBlue,
        accentColor: accentColor ?? AppColors.lmcOrange,
        text: message ?? "Loading",
        textStyle: textStyle ?? TextStyle(
          fontSize: messageSize ?? 16.sp,
          fontWeight: FontWeight.w600,
          color: messageColor ?? AppColors.lmcBlue,
          letterSpacing: 1,
        ),
      ),
    );
  }

  /// Helper method to create decorative dots
  static Widget _buildDot(Color color) {
    return Container(
      width: 6.w,
      height: 6.h,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// The LMC Loading Indicator Widget (add this to your project)
class LMCLoadingIndicator extends StatefulWidget {
  final double size;
  final Color primaryColor;
  final Color accentColor;
  final String text;
  final TextStyle? textStyle;

  const LMCLoadingIndicator({
    Key? key,
    this.size = 120.0,
    this.primaryColor = const Color(0xFF1A365D),
    this.accentColor = const Color(0xFFFF8C00),
    this.text = "Loading",
    this.textStyle,
  }) : super(key: key);

  @override
  State<LMCLoadingIndicator> createState() => _LMCLoadingIndicatorState();
}

class _LMCLoadingIndicatorState extends State<LMCLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _ringController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _dotsController;

  late Animation<double> _ringAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _dotsAnimation;

  @override
  void initState() {
    super.initState();

    _ringController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _ringAnimation = Tween<double>(begin: 0, end: 1).animate(_ringController);
    _pulseAnimation = Tween<double>(begin: 0, end: 1).animate(_pulseController);
    _floatAnimation = Tween<double>(begin: 0, end: 1).animate(_floatController);
    _dotsAnimation = Tween<double>(begin: 0, end: 1).animate(_dotsController);
  }

  @override
  void dispose() {
    _ringController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animated rings
              AnimatedBuilder(
                animation: _ringAnimation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Transform.rotate(
                        angle: _ringAnimation.value * 2 * 3.14159,
                        child: Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border(
                              top: BorderSide(
                                color: widget.primaryColor,
                                width: 4,
                              ),
                              right: BorderSide.none,
                              bottom: BorderSide.none,
                              left: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: -_ringAnimation.value * 1.5 * 2 * 3.14159,
                        child: Container(
                          width: widget.size - 8,
                          height: widget.size - 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border(
                              bottom: BorderSide(
                                color: widget.accentColor,
                                width: 4,
                              ),
                              top: BorderSide.none,
                              right: BorderSide.none,
                              left: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Animated M letter
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(widget.size * 0.5, widget.size * 0.5),
                    painter: MLetterPainter(
                      primaryColor: widget.primaryColor,
                      accentColor: widget.accentColor,
                      animationValue: _pulseAnimation.value,
                    ),
                  );
                },
              ),

              // Floating books
              Positioned(
                bottom: -10,
                child: AnimatedBuilder(
                  animation: _floatAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -8 * (0.5 - (_floatAnimation.value - 0.5).abs())),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildBook(widget.primaryColor, 0),
                          SizedBox(width: 4.w),
                          _buildBook(widget.accentColor, 0.33),
                          SizedBox(width: 4.w),
                          _buildBook(widget.primaryColor, 0.66),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // Loading text with animated dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: widget.textStyle,
            ),
            SizedBox(width: 5.w),
            AnimatedBuilder(
              animation: _dotsAnimation,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    double delay = index * 0.3;
                    double animValue = (_dotsAnimation.value + delay) % 1.0;
                    double scale = 1.0 + 0.5 * (0.5 - (animValue - 0.5).abs());
                    double opacity = 0.7 + 0.3 * (0.5 - (animValue - 0.5).abs());
                    
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 4.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: widget.accentColor.withOpacity(opacity),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBook(Color color, double delay) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        double animValue = (_floatAnimation.value + delay) % 1.0;
        double offset = -8 * (0.5 - (animValue - 0.5).abs());
        
        return Transform.translate(
          offset: Offset(0, offset),
          child: Container(
            width: 12.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      },
    );
  }
}

class MLetterPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;
  final double animationValue;

  MLetterPainter({
    required this.primaryColor,
    required this.accentColor,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint primaryPaint = Paint()
      ..color = primaryColor.withOpacity(0.8 + 0.2 * (0.5 - (animationValue - 0.5).abs()))
      ..style = PaintingStyle.fill;

    final Paint accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    double width = size.width;
    double height = size.height;
    double strokeWidth = 8;

    double pulseScale = 1.0 + 0.2 * (0.5 - (animationValue - 0.5).abs());
    canvas.scale(pulseScale);

    // Left vertical line
    canvas.drawRect(
      Rect.fromLTWH(0, 0, strokeWidth, height),
      primaryPaint,
    );

    // Right vertical line
    canvas.drawRect(
      Rect.fromLTWH(width - strokeWidth, 0, strokeWidth, height),
      primaryPaint,
    );

    // Center vertical line
    canvas.drawRect(
      Rect.fromLTWH((width - strokeWidth) / 2, 0, strokeWidth, height * 0.67),
      primaryPaint,
    );

    // Animated diagonal lines
    double diagonalOpacity = (0.5 - (animationValue - 0.5).abs()) * 2;
    if (diagonalOpacity > 0) {
      Paint diagonalPaint = Paint()
        ..color = accentColor.withOpacity(diagonalOpacity)
        ..style = PaintingStyle.fill;

      // Left diagonal
      Path leftDiagonal = Path();
      leftDiagonal.moveTo(strokeWidth, 0);
      leftDiagonal.lineTo((width - strokeWidth) / 2, height * 0.4);
      leftDiagonal.lineTo((width - strokeWidth) / 2 + strokeWidth, height * 0.4);
      leftDiagonal.lineTo(strokeWidth * 2, 0);
      leftDiagonal.close();
      canvas.drawPath(leftDiagonal, diagonalPaint);

      // Right diagonal
      Path rightDiagonal = Path();
      rightDiagonal.moveTo(width - strokeWidth, 0);
      rightDiagonal.lineTo((width - strokeWidth) / 2 + strokeWidth, height * 0.4);
      rightDiagonal.lineTo((width - strokeWidth) / 2, height * 0.4);
      rightDiagonal.lineTo(width - strokeWidth * 2, 0);
      rightDiagonal.close();
      canvas.drawPath(rightDiagonal, diagonalPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
import 'package:flutter/material.dart';

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

    // Ring rotation animation
    _ringController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Pulse animation for M letter
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Float animation for books
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Dots animation
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
                      // Outer ring
                      Transform.rotate(
                        angle: _ringAnimation.value * 2 * 3.14159,
                        child: Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 4,
                            ),
                          ),
                          child: Container(
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
                      ),
                      // Inner ring (reverse rotation)
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
                          const SizedBox(width: 4),
                          _buildBook(widget.accentColor, 0.33),
                          const SizedBox(width: 4),
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

        const SizedBox(height: 20),

        // Loading text with animated dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: widget.textStyle ??
                  TextStyle(
                    color: widget.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
            ),
            const SizedBox(width: 5),
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
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 4,
                          height: 4,
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
            width: 12,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
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

    // Pulse effect
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

// Usage example widget
class LMCLoadingScreen extends StatelessWidget {
  const LMCLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: const Center(
        child: LMCLoadingIndicator(
          size: 120,
          text: "LMC",
          primaryColor: Color(0xFF1A365D),
          accentColor: Color(0xFFFF8C00),
        ),
      ),
    );
  }
}

// Alternative compact version for smaller spaces
class LMCCompactLoader extends StatelessWidget {
  const LMCCompactLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LMCLoadingIndicator(
      size: 60,
      text: "LMC",
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A365D),
      ),
    );
  }
}
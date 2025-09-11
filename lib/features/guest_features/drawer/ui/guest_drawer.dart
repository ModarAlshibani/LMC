import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/for_all/login/logic/cubit/logout_cubit.dart';
import 'dart:math' as math;
import '../../../../core/theming/colors.dart' show AppColors;

class GuestDrawer extends StatefulWidget {
  final int? id;

  const GuestDrawer({super.key, this.id});

  @override
  State<GuestDrawer> createState() => _GuestDrawerState();
}

class _GuestDrawerState extends State<GuestDrawer> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Initialize animations
    _slideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutQuart),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    // Start animations
    _slideController.forward();
    _pulseController.repeat(reverse: true);
    _waveController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: double.infinity,
      child: Stack(
        children: [
          // Background with wave effect
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return CustomPaint(
                painter: WavePainter(_waveAnimation.value, AppColors.lmcBlue),
                size: const Size(320, double.infinity),
              );
            },
          ),

          // Main drawer content
          Container(
            decoration: BoxDecoration(
              color: AppColors.lmcBlue,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lmcBlue.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(10, 0),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _slideController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_slideAnimation.value * 320, 0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        _buildAnimatedHeader(),
                        Expanded(child: _buildMenuItems()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
      decoration: BoxDecoration(color: AppColors.lmcBlue),
      child: Column(
        children: [
          // Animated logo
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer ring
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.lmcOrange.withOpacity(
                          0.3 + (_pulseAnimation.value * 0.2),
                        ),
                        width: 3,
                      ),
                    ),
                  ),
                  // Middle ring
                  Transform.scale(
                    scale: 1.0 + (_pulseAnimation.value * 0.05),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, AppColors.background2],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lmcOrange.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Icon
                  Transform.rotate(
                    angle: _pulseAnimation.value * 0.5,
                    child: Image(
                      image: const AssetImage('assets/images/LMC-LOGO.png'),
                      width: 90,
                    ),
                  ),
                ],
              );
            },
          ),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      colors: [Colors.white, AppColors.lmcOrange, Colors.white],
                      stops: [0.0, _pulseAnimation.value, 1.0],
                    ).createShader(bounds),
                child: const Text(
                  "LMC",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              );
            },
          ),

          // Animated divider
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.lmcOrange,
                      Colors.transparent,
                    ],
                    stops: [0.0, _waveAnimation.value, 1.0],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      _MenuItem(
        icon: Iconsax.profile_circle,
        title: "My Profile",
        subtitle: "Personal settings",
        isLogout: false,
        onTap: () =>  Navigator.pushNamed(
                              context,
                              Routes.my_profile,
                            ),
      ),
      _MenuItem(
        icon: Iconsax.info_circle,
        title: "About Us",
        subtitle: "Learn more",
        isLogout: false,
        onTap: () =>  Navigator.pushNamed(
                              context,
                              Routes.lmc_info,
                            ),
      ),
      _MenuItem(
        icon: Iconsax.calendar,
        title: "LMC Holidays",
        subtitle: "Off days",
        isLogout: false,
        onTap: () => Navigator.pushNamed(context, Routes.holidays_screen),
      ),
      _MenuItem(
        icon: Iconsax.logout,
        title: "Logout",
        subtitle: "Sign out of account",
        isLogout: true,
        onTap: () {
          context.read<AuthCubit>().logOut();
        },
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 500 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset((1 - value) * 100, 0),
              child: Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: _buildAnimatedMenuItem(menuItems[index], index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAnimatedMenuItem(_MenuItem item, int index) {
    final isHovered = _hoveredIndex == index;
    final isLogout = item.isLogout;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient:
            isHovered
                ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors:
                      isLogout
                          ? [
                            Colors.red.withOpacity(0.15),
                            Colors.red.withOpacity(0.1),
                          ]
                          : [
                            AppColors.lmcOrange.withOpacity(0.1),
                            AppColors.hintBlue.withOpacity(0.1),
                          ],
                )
                : null,
        color: isHovered ? null : Colors.white.withOpacity(0.7),
        border: Border.all(
          color:
              isHovered
                  ? isLogout
                      ? Colors.red.withOpacity(0.4)
                      : AppColors.lmcOrange.withOpacity(0.4)
                  : AppColors.greyBorder.withOpacity(0.2),
          width: isHovered ? 2 : 1,
        ),
        boxShadow:
            isHovered
                ? [
                  BoxShadow(
                    color:
                        isLogout
                            ? Colors.red.withOpacity(0.15)
                            : AppColors.lmcOrange.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
                : [
                  BoxShadow(
                    color: AppColors.greyBorder.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: item.onTap,
          onHover: (hovering) {
            setState(() {
              _hoveredIndex = hovering ? index : null;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient:
                        isHovered
                            ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors:
                                  isLogout
                                      ? [
                                        Colors.red,
                                        Colors.red.withOpacity(0.7),
                                      ]
                                      : [
                                        AppColors.lmcOrange,
                                        AppColors.lmcOrange.withOpacity(0.7),
                                      ],
                            )
                            : LinearGradient(
                              colors:
                                  isLogout
                                      ? [
                                        Colors.red.withOpacity(0.3),
                                        Colors.red.withOpacity(0.1),
                                      ]
                                      : [
                                        AppColors.hintBlue.withOpacity(0.3),
                                        AppColors.background2,
                                      ],
                            ),
                    boxShadow:
                        isHovered
                            ? [
                              BoxShadow(
                                color:
                                    isLogout
                                        ? Colors.red.withOpacity(0.3)
                                        : AppColors.lmcOrange.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : null,
                  ),
                  child: Transform.scale(
                    scale: isHovered ? 1.1 : 1.0,
                    child: Icon(
                      item.icon,
                      color:
                          isHovered
                              ? Colors.white
                              : isLogout
                              ? Colors.red
                              : AppColors.lmcBlue,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight:
                              isHovered ? FontWeight.w700 : FontWeight.w600,
                          color: isLogout ? Colors.red : AppColors.lmcBlue,
                        ),
                        child: Text(item.title),
                      ),
                      const SizedBox(height: 3),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color:
                              isHovered
                                  ? isLogout
                                      ? Colors.red.withOpacity(0.8)
                                      : AppColors.lmcBlue.withOpacity(0.9)
                                  : isLogout
                                  ? Colors.red.withOpacity(0.7)
                                  : AppColors.lmcBlue.withOpacity(0.7),
                        ),
                        child: Text(item.subtitle),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: isHovered ? 35 : 0,
                  child:
                      isHovered
                          ? Icon(
                            Iconsax.arrow_right,
                            size: 20,
                            color: isLogout ? Colors.red : AppColors.lmcOrange,
                          )
                          : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildAnimatedFooter() {
  //   return Container(
  //     padding: const EdgeInsets.all(25),
  //     decoration: BoxDecoration(
  //       color: AppColors.lmcBlue,
  //       border: Border(
  //         top: BorderSide(
  //           color: AppColors.greyBorder.withOpacity(0.2),
  //           width: 1,
  //         ),
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         // Animated divider
  //         AnimatedBuilder(
  //           animation: _waveController,
  //           builder: (context, child) {
  //             return Container(
  //               width: double.infinity,
  //               height: 2,
  //               decoration: BoxDecoration(
  //                 gradient: LinearGradient(
  //                   colors: [
  //                     Colors.transparent,
  //                     AppColors.lmcOrange.withOpacity(0.5),
  //                     AppColors.hintBlue.withOpacity(0.5),
  //                     Colors.transparent,
  //                   ],
  //                   stops: [
  //                     0.0,
  //                     _waveAnimation.value * 0.5,
  //                     _waveAnimation.value * 0.5 + 0.2,
  //                     1.0,
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),

  //         const SizedBox(height: 20),

  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             _buildAnimatedFooterButton(
  //               Iconsax.setting,
  //               "Settings",
  //               AppColors.lmcBlue,
  //             ),
  //             _buildAnimatedFooterButton(
  //               Iconsax.message_question,
  //               "Help",
  //               AppColors.lmcOrange,
  //             ),
  //             _buildAnimatedFooterButton(
  //               Iconsax.logout,
  //               "Logout",
  //               AppColors.red,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //   Widget _buildAnimatedFooterButton(
  //     IconData icon,
  //     String tooltip,
  //     Color color,
  //   ) {
  //     return Tooltip(
  //       message: tooltip,
  //       preferBelow: false,
  //       textStyle: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 13,
  //         fontWeight: FontWeight.w500,
  //       ),
  //       decoration: BoxDecoration(
  //         color: AppColors.lmcBlue.withOpacity(0.9),
  //         borderRadius: BorderRadius.circular(10),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.2),
  //             blurRadius: 8,
  //             offset: const Offset(2, 2),
  //           ),
  //         ],
  //       ),
  //       child: AnimatedBuilder(
  //         animation: _pulseController,
  //         builder: (context, child) {
  //           return Container(
  //             width: 60,
  //             height: 60,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               gradient: RadialGradient(
  //                 colors: [
  //                   color.withOpacity(0.15),
  //                   color.withOpacity(0.05),
  //                   Colors.transparent,
  //                 ],
  //                 radius: 1.0 + (_pulseAnimation.value * 0.2),
  //               ),
  //               border: Border.all(
  //                 color: color.withOpacity(0.4 + (_pulseAnimation.value * 0.2)),
  //                 width: 2,
  //               ),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: color.withOpacity(0.2),
  //                   blurRadius: 10,
  //                   offset: const Offset(0, 3),
  //                 ),
  //               ],
  //             ),
  //             child: Material(
  //               color: Colors.transparent,
  //               shape: const CircleBorder(),
  //               child: InkWell(
  //                 customBorder: const CircleBorder(),
  //                 onTap: () {},
  //                 child: Transform.scale(
  //                   scale: 1.0 + (_pulseAnimation.value * 0.03),
  //                   child: Icon(icon, size: 26, color: color),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //   }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLogout;
  final VoidCallback onTap;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isLogout,
    required this.onTap,
  });
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final Color waveColor;

  WavePainter(this.animationValue, this.waveColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw multiple wave layers
    for (int i = 0; i < 3; i++) {
      paint.color = waveColor.withOpacity(0.03 - (i * 0.01));

      final path = Path();
      path.moveTo(0, 0);

      for (double x = 0; x <= size.width; x++) {
        final y =
            math.sin(
                  (x / size.width * 2 * math.pi) +
                      (animationValue * 2 * math.pi) +
                      (i * math.pi / 3),
                ) *
                20 +
            50 +
            (i * 30);

        if (x == 0) {
          path.lineTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      path.lineTo(size.width, 0);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

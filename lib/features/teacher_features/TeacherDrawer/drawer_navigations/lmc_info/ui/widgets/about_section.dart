import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/theming/colors.dart';

class AboutSection extends StatelessWidget {
  final dynamic info;
  final int index;
  final Animation<double> fade;
  final Animation<double> slide;

  const AboutSection({super.key, required this.info, required this.index, required this.fade, required this.slide});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fade,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slide.value),
          child: Opacity(
            opacity: fade.value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFF8F9FA)],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lmcBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lmcOrange,
                    ),
                  ),
                  const SizedBox(height: 40),
                  if (info.description != null)
                    ...info.description!.asMap().entries.map<Widget>((entry) {
                      int i = entry.key;
                      var desc = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: i.isEven
                                  ? [
                                      Colors.white,
                                      AppColors.lmcBlue.withOpacity(0.02),
                                      AppColors.lmcOrange.withOpacity(0.02),
                                    ]
                                  : [
                                      AppColors.lmcBlue.withOpacity(0.02),
                                      Colors.white,
                                      AppColors.lmcBlue.withOpacity(0.03),
                                    ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lmcBlue.withOpacity(0.1),
                                blurRadius: 40,
                                offset: const Offset(0, 20),
                                spreadRadius: -5,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            border: Border.all(
                              color: AppColors.lmcBlue.withOpacity(0.08),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.lmcOrange,
                                            AppColors.lmcOrange.withOpacity(0.8),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          i == 1 ? Iconsax.location_tick : Iconsax.flag_2,
                                          color: AppColors.background2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            desc.title ?? '',
                                            style: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.lmcBlue,
                                              height: 1.2,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            height: 3,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2),
                                              gradient: const LinearGradient(
                                                colors: [AppColors.lmcOrange, AppColors.lmcBlue],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 28),
                                Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade50,
                                    border: Border.all(
                                      color: AppColors.lmcBlue.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    desc.explanation ?? '',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[800],
                                      height: 1.8,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

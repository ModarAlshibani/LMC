import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/data/languages_have_library_model.dart';

class LanguagesHaveLibraryOutside extends StatelessWidget {
  final LanguagesHaveLibrary languagesHaveLibrary;

  const LanguagesHaveLibraryOutside({super.key, required this.languagesHaveLibrary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.lang_files, arguments: languagesHaveLibrary);
      },
      child: Stack(
        children: [
          Container(
            
                    width: 145.w,
                    height: 145.h,
                    decoration: BoxDecoration(
                      color: AppColors.lmcBlue,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage('assets/images/LMC-LOGO.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox.shrink(),
                  ),
          Positioned(
            bottom: 0,
            child: GlassContainer(
              height: 30.h,
              width: 145,
              bottomLeft: 10,
              bottomRight: 10,
              firstColor: AppColors.lmcOrange,
              secondColor: AppColors.lmcOrange,
              topLeft: 0,
              topRight: 0,
              firstBlurOpacity: 0.3,
              secondBlurOpacity: 0.25,
              sigmaX: 100,
              sigmaY: 100,
              withBorder: false,
              child: Center(
                child: Text(
                  "${languagesHaveLibrary.name}",
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            
            ),
          ),        
        ],
      ),
    );
  }
}


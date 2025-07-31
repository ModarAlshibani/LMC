
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/cubit/;mc_info_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/cubit/lmc_info_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/widgets/about_section.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/widgets/error_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/widgets/hero_section.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/widgets/languages_section.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/widgets/loading_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/widgets/mission_section.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/widgets/teachers_section.dart';


class LmcInfoScreen extends StatefulWidget {
  const LmcInfoScreen({super.key});

  @override
  State<LmcInfoScreen> createState() => _LmcInfoScreenState();
}

class _LmcInfoScreenState extends State<LmcInfoScreen> with TickerProviderStateMixin {
  ScrollController? _scrollController;
  AnimationController? _heroController;
  List<AnimationController>? _sectionControllers;
  List<Animation<double>>? _slideAnimations;
  List<Animation<double>>? _fadeAnimations;
  List<Animation<double>>? _scaleAnimations;

  final List<GlobalKey> _sectionKeys = List.generate(6, (index) => GlobalKey());
  final List<bool> _sectionVisible = List.generate(6, (index) => false);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _heroController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _sectionControllers = List.generate(
      6,
      (index) => AnimationController(duration: const Duration(milliseconds: 1200), vsync: this),
    );
    _slideAnimations = _sectionControllers!.map((c) => Tween<double>(begin: 100, end: 0).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic))).toList();
    _fadeAnimations = _sectionControllers!.map((c) => Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut))).toList();
    _scaleAnimations = _sectionControllers!.map((c) => Tween<double>(begin: 0.8, end: 1).animate(CurvedAnimation(parent: c, curve: Curves.elasticOut))).toList();
    _scrollController!.addListener(_onScroll);
    _heroController!.forward();
  }

  void _onScroll() {
    final scrollOffset = _scrollController!.offset;
    final viewportHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          final sectionTop = position.dy + scrollOffset;
          final sectionBottom = sectionTop + box.size.height;
          if (sectionTop < scrollOffset + viewportHeight * 0.8 && sectionBottom > scrollOffset && !_sectionVisible[i]) {
            _sectionVisible[i] = true;
            _sectionControllers![i].forward();
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _heroController?.dispose();
    if (_sectionControllers != null) {
      for (var controller in _sectionControllers!) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BlocBuilder<LmcInfoCubit, LmcInfoState>(
            builder: (context, state) {
              if (state is LmcInfoLoading) return const LoadingState();
              if (state is LmcInfoFailure) return ErrorState(error: state.error);
              if (state is LmcInfoSuccess) {
                final info = state.lmcInfo;
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      HeroSection(info: info, controller: _heroController!),
                      AboutSection(info: info, index: 0, key: _sectionKeys[0], fade: _fadeAnimations![0], slide: _slideAnimations![0]),
                      MissionSection(key: _sectionKeys[1], fade: _fadeAnimations![1], scale: _scaleAnimations![1]),
                      TeachersSection(info: info, key: _sectionKeys[2], fade: _fadeAnimations![2], slide: _slideAnimations![2]),
                      LanguagesSection(info: info, key: _sectionKeys[3], fade: _fadeAnimations![3], scale: _scaleAnimations![3]),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Positioned(
            top: 60,
            left: 40,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.lmcOrange.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.arrow_back_ios_new, color: AppColors.background2, size: 20.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}

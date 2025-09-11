// lib/features/student_features/show_teachers/ui/screens/show_teachers_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/features/student_features/show_teachers/logic/cubit/show_teachers_cubit.dart';
import '../../../../guest_features/guest_homePage/ui/widgets/top_container.dart';
import '../widgets/teachers_list.dart';

class ShowTeachersScreen extends StatefulWidget {
  const ShowTeachersScreen({super.key});

  @override
  State<ShowTeachersScreen> createState() => _ShowTeachersScreenState();
}

class _ShowTeachersScreenState extends State<ShowTeachersScreen> {
  String _query = '';

  @override
  void initState() {
    super.initState();
    context.read<ShowTeachersCubit>().fetchAllTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: Stack(
        children: [
          Positioned(
            top: -110.h, left: -30.w, right: -30.w,
            child: TopContainer(height: 300.h, border: true),
          ),
          Positioned(
            top: 50.h, left: 80.w, right: 50.w,
            child: Center(
              child: Text(
                "LMC Teachers",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Positioned(
            top: 210.h, left: 30, right: 30,
            child: GeneralTextFormField(
              fillColor: AppColors.backgroundColor,
              hintText: "Search",
              hintTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.lmcBlue,
              ),
              prefixIcon: Icon(Icons.search, size: 30, color: AppColors.lmcBlue),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.lmcOrange.withOpacity(0.6),
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Positioned(
            top: 280.h, right: 30.w, left: 30.w, bottom: 20,
            child: BlocBuilder<ShowTeachersCubit, ShowTeachersState>(
              builder: (context, state) {
                if (state is ShowTeachersLoading || state is ShowTeachersInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ShowTeachersFailure) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                if (state is ShowTeachersSuccess) {
                  final all = state.teachers;
                  final q = _query.trim().toLowerCase();
                  final filtered = q.isEmpty
                      ? all
                      : all.where((t) => (t.name ?? '').toLowerCase().contains(q)).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        'No results found!',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.lmcBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }

                  return TeachersList(teachers: filtered);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

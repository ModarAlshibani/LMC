import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/helpers/extentions.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';
import 'package:lmc_app/features/login/logic/cubit/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen:
          (previous, current) =>
              previous is Loading || current is Success || current is Error,

      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder:
                  (context) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.lmcOrange,
                    ),
                  ),
            );
          },
          success: (response) {
            context.pop();
            context.pushNamed(Routes.homePage);
          },
          error: (error) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(content: Text(error)),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}

// presentation/widgets/login_bloc_listener.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  final Widget child;

  const LoginBlocListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // On success, navigate to the home screen or show user details
          print("user role is ${state.user?.role}");
          if (state.user?.role == 'Guest') {
            Navigator.pushReplacementNamed(context, Routes.guest_homePage);
          } else if (state.user?.role == 'Student') {
          } else if (state.user?.role == 'Teacher') {
          } else if (state.user?.role == 'Logistic') {
            Navigator.pushReplacementNamed(context, Routes.logistic_homePage);
          }
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: child,
    );
  }
}

// presentation/widgets/login_bloc_listener.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';
import 'package:lmc_app/core/routing/routes.dart';

class LoginBlocListener extends StatelessWidget {
  final Widget child;

  const LoginBlocListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // On success, navigate to the home screen or show user details
          Navigator.pushReplacementNamed(context, Routes.homePage); // or '/home'
        } else if (state is LoginFailure) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: child,
    );
  }
}

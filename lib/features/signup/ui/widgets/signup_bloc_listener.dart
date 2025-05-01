// presentation/widgets/login_bloc_listener.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';

import '../../logic/cubit/signup_cubit.dart';

class SignupBlocListener extends StatelessWidget {
  final Widget child;

  const SignupBlocListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<signupCubit, signupState>(
      listener: (context, state) {
        if (state is signupSuccess) {
          // On success, navigate to the home screen or show user details
          Navigator.pushReplacementNamed(
            context,
            Routes.homePage,
          ); // or '/home'
        } else if (state is signupFailure) {
          // Show error message
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: child,
    );
  }
}

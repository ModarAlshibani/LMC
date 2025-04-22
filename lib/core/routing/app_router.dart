import 'package:flutter/material.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/login/ui/screens/login_screen.dart';
import 'package:lmc_app/features/onboarding/ui/screens/onboarding_screen.dart';

import '../../features/homePage/ui/screens/signUp.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
//this value is to be passed in any screen like this (arguments as ClassName)
final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

        case Routes.signUp:
          return MaterialPageRoute(builder: (_) => const SignUp());

        // case Routes.homePage:
        //   return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}

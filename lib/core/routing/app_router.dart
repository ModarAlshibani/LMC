import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/announsments/logic/cubit/all_announcements_cubit.dart';
import '../../features/guest_homePage/ui/screens/guest_home_page_screen.dart';
import '../../features/logistic_app/home_page/ui/screen/logistic_homepage.dart';
import '../../features/logistic_app/send_invoice/ui/screens/send_invoice.dart';
import '../../features/logistic_app/show_tasks/ui/screens/show_tasks.dart';
import '../../features/signup/logic/cubit/signup_cubit.dart';

import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/screens/login_screen.dart';
import '../../features/onboarding/ui/screens/onboarding_screen.dart';
import '../../features/signup/ui/screens/signup_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: LoginScreen(),
              ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<signupCubit>(),
                child: SignUp(),
              ),
        );

      case Routes.guest_homePage:
      return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AllAnnouncementsCubit>(),
                child: GuestHomePageScreen(),
              ),
        );
      case Routes.logistic_homePage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AllAnnouncementsCubit>(),
                child: LogisticHomepage(),
              ),
        );
      case Routes.show_tasks:
        return MaterialPageRoute(builder: (_) =>  ShowTasks());

      case Routes.send_invoice:
        return MaterialPageRoute(builder: (_) =>  SendInvoice());

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

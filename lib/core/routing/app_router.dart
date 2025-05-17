import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/courses/logic/cubit/cubit/available_courses_cubit.dart';
import 'package:lmc_app/features/for_all/courses/ui/screens/upcomming_courses.dart';
import 'package:lmc_app/features/logistic_features/show_done_tasks/screen/show_done_tasks.dart';
import 'package:lmc_app/features/logistic_features/show_done_tasks/widgets/done_tasks_list.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import '../../features/guest_features/guest_homePage/ui/screens/guest_home_page_screen.dart';
import '../../features/logistic_features/home_page/ui/screen/logistic_homepage.dart';
import '../../features/logistic_features/send_invoice/ui/screens/send_invoice.dart';
import '../../features/logistic_features/show_tasks/ui/screens/show_tasks.dart';
import '../../features/for_all/signup/logic/cubit/signup_cubit.dart';

import '../../features/for_all/login/logic/cubit/login_cubit.dart';
import '../../features/for_all/login/ui/screens/login_screen.dart';
import '../../features/for_all/onboarding/ui/screens/onboarding_screen.dart';
import '../../features/for_all/signup/ui/screens/signup_screen.dart';
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
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AllTasksCubit>(),
                child: ShowTasks(),
              ),
        );
      case Routes.done_tasks:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AllTasksCubit>(),
                child: ShowDoneTasks(),
              ),
        );

      case Routes.send_invoice:
        return MaterialPageRoute(builder: (_) => SendInvoice());

      case Routes.available_courses:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AvailableCoursesCubit>(),
                child: AvailableCourses(),
              ),
        );

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

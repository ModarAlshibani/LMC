import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart'
    hide CourseSchedule;
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/logic/cubit/student_my_courses_cubit.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/ui/screens/student_my_course_details.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/ui/screens/student_my_courses_screen.dart';
import 'package:lmc_app/features/student_features/navBar.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';
import 'package:lmc_app/features/student_features/show_teachers/logic/cubit/show_teachers_cubit.dart';
import 'package:lmc_app/features/student_features/show_teachers/ui/screens/show_teachers_screen.dart';
import 'package:lmc_app/features/student_features/show_teachers/ui/screens/teacher_profile_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/ui/screens/teacher_lessons_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/data/model/my_courses_teacher_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/ui/screens/teacher_course_details_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_homepage/teacher_homepage.dart';
import 'package:lmc_app/features/teacher_features/teacher_navbar.dart';

import '../../features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import '../../features/for_all/available_courses/logic/cubit/cubit/available_courses_cubit.dart';
import '../../features/for_all/available_courses/ui/screens/upcomming_courses.dart';
import '../../features/for_all/login/logic/cubit/login_cubit.dart';
import '../../features/for_all/login/ui/screens/login_screen.dart';
import '../../features/for_all/onboarding/ui/screens/onboarding_screen.dart';
import '../../features/for_all/signup/logic/cubit/signup_cubit.dart';
import '../../features/for_all/signup/ui/screens/signup_screen.dart';
import '../../features/guest_features/guest_homePage/ui/screens/guest_home_page_screen.dart';
import '../../features/logistic_features/home_page/ui/screen/logistic_homepage.dart';
import '../../features/logistic_features/send_invoice/logic/cubit/send_invoice_cubit.dart';
import '../../features/logistic_features/send_invoice/ui/screens/send_invoice_screen.dart';
import '../../features/logistic_features/show_done_tasks/screen/show_done_tasks.dart';
import '../../features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import '../../features/logistic_features/show_tasks/ui/screens/show_tasks.dart';
import '../../features/student_features/my_courses/show_lessons/logic/cubit/lessons_cubit.dart';
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
        final args = settings.arguments as Map<String, dynamic>;
        final taskId = args['taskId'] as int;
        final content = args['content'] as String;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SendInvoiceCubit>(),
                child: SendInvoiceScreen(taskId: taskId, content: content),
              ),
        );

      case Routes.available_courses:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AvailableCoursesCubit>(),
                child: AvailableCourses(),
              ),
        );

      case Routes.teacher_navbar:
        return MaterialPageRoute(builder: (_) => TeacherNavBar());

      case Routes.teacher_homepage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AllAnnouncementsCubit>(),
                child: TeacherHomepage(),
              ),
        );

      case Routes.show_teachers:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ShowTeachersCubit>(),
                child: ShowTeachersScreen(),
              ),
        );

      case Routes.show_teacher_profile:
        final teacher = settings.arguments as Teachers;
        return MaterialPageRoute(
          builder: (_) => TeacherProfileScreen(teacher: teacher),
        );

      case Routes.lessons_list:
        final courseId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => getIt<LessonsCubit>()..fetchLessons(courseId),
                child: TeacherLessonsScreen(),
              ),
        );

      //--------------------------------------------------------

      case Routes.teacher_lessons_list:
        final courseId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<TeacherLessonsCubit>()..fetchLessons(courseId),
                child: TeacherLessonsScreen(),
              ),
        );
      //--------------------------------------------------------

      case Routes.navBar:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AllAnnouncementsCubit>(),
                child: NavBar(),
              ),
        );

      case Routes.student_my_courses:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<StudentMyCoursesCubit>(),
                child: StudentMyCoursesScreen(),
              ),
        );

      case Routes.student_my_course_details:
        final course = settings.arguments as MyCoursesStu;
        return MaterialPageRoute(
          builder: (_) => StudentMyCourseDetails(course: course),
        );
      //----------------------------------------------------------
      case Routes.teacher_my_course_details:
        final args = settings.arguments as Map<String, dynamic>;
        final course = args['course'] as MyCourses;
        final courseSchedule = args['schedule'] as CourseSchedule;
        return MaterialPageRoute(
          builder:
              (_) => TeacherMyCourseDetails(
                course: course,
                courseSchedule: courseSchedule,
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

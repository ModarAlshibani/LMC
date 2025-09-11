import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/available_courses/logic/cubit/cubit/available_courses_cubit.dart';
import 'package:lmc_app/features/for_all/available_courses/ui/screens/upcomming_courses.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/cubit/holidays_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/usecases/get_holidays_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/ui/screens/holidays_screen.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/cubit/language_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/usecases/language_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/cubit/lang_files_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/usecases/lang_files_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/ui/screens/lang_files_screen.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/data/languages_have_library_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/cubit/languages_have_library_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/usecases/languages_have_library_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/ui/screens/languages_have_library_screen.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/cubit/lmc_info_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/usecases/lmc_info_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/ui/screens/lmc_info_screen.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/usecases/edit_my_profile_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/usecases/my_profile_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/ui/screens/my_profile_screen.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/cubit/private_course_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/add_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/delete_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/edit_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/get_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/ui/screens/private_courses_screen.dart';
import 'package:lmc_app/features/for_all/placement_tests/ui/screens/placement_test_screen.dart';
import 'package:lmc_app/features/logistic_features/send_invoice/logic/cubit/send_invoice_cubit.dart';
import 'package:lmc_app/features/logistic_features/show_done_tasks/screen/show_done_tasks.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/student_features/lessons_management/self_test/self_test_details/ui/screens/selftest_details_screen.dart';
import 'package:lmc_app/features/student_features/lessons_management/self_test/selftests_list/ui/screens/selftests_screen.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/data/models/lessons_model.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/logic/cubit/lessons_cubit.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/ui/screens/lessons_list.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/ui/screens/stu_lesson_screen.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/logic/cubit/stu_flashcard_cubit.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/ui/screens/flashcards_screen.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart'
    hide CourseSchedule;
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/logic/cubit/student_my_courses_cubit.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/ui/screens/student_my_courses_screen.dart';
import 'package:lmc_app/features/student_features/navBar.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';
import 'package:lmc_app/features/student_features/show_teachers/logic/cubit/show_teachers_cubit.dart';
import 'package:lmc_app/features/student_features/show_teachers/ui/screens/show_teachers_screen.dart';
import 'package:lmc_app/features/student_features/show_teachers/ui/screens/teacher_profile_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/enter_bonus_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/get_students_names_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/mark_attendance_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/ui/screens/attendance_and_marks_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/send_task_to_sec/logic/cubit/send_task_to_sec_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/send_task_to_sec/ui/send_task_to_sec_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/add_flashcard/logic/cubit/add_flashcard_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/add_flashcard/ui/screens/add_flashcard_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/edit_flashcard/logic/cubit/edit_flashcard_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/edit_flashcard/ui/screens/edit_flashcard_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/logic/cubit/teacher_lesson_flashcard_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/ui/screens/teacher_lesson_flashcards_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_lesson_details/ui/screens/teacher_lesson_details.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest/logic/cubit/add_selftest_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest/ui/screens/add_selftest_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/logic/cubit/add_selftest_question_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/ui/screens/teacher_st_add_selftest_questions_screen.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/selftest_details/ui/screens/teacher_selftest_details.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/logic/cubit/selftests_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/ui/screens/teacher_selftests_screen.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/cubit/edit_complaint_cubit.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/cubit/my_complaints_cubit.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/cubit/submit_complaint_cubit.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/ui/screens/edit_complaint_screen.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/ui/screens/my_complaints_screen.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/ui/screens/submit_complaint_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/logic/cubit/course_flashcards_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/ui/course_flashcards_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_students/ui/screen/course_students_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/add_final_test_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/add_final_test_question_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/get_final_test_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/get_final_test_questions_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/screens/add_final_exam.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/screens/teacher_final_test_details_screen.dart.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/screens/teacher_final_test_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/screens/teacher_ft_add_questions_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/ui/screens/teacher_lessons_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/data/model/my_courses_teacher_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/ui/screens/teacher_course_details_screen.dart';
import 'package:lmc_app/features/teacher_features/teacher_homepage/teacher_homepage.dart';
import 'package:lmc_app/features/teacher_features/teacher_navbar.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/logic/cubit/show_schedule_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/ui/screen/calendar_screen.dart';

import '../../features/for_all/login/logic/cubit/login_cubit.dart';
import '../../features/for_all/login/ui/screens/login_screen.dart';
import '../../features/for_all/onboarding/ui/screens/onboarding_screen.dart';
import '../../features/for_all/signup/logic/cubit/signup_cubit.dart';
import '../../features/for_all/signup/ui/screens/signup_screen.dart';
import '../../features/guest_features/guest_homePage/ui/screens/guest_home_page_screen.dart';
import '../../features/logistic_features/home_page/ui/screen/logistic_homepage.dart';
import '../../features/logistic_features/send_invoice/ui/screens/send_invoice_screen.dart';
import '../../features/logistic_features/show_tasks/ui/screens/show_tasks.dart';
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

      //----------------------------------------------------------
      case Routes.placement_test_screen:
        return MaterialPageRoute(builder: (_) => PlacementTestScreen());

      //----------------------------------------------------------

      case Routes.lessons_list:
        final course = settings.arguments as MyCoursesStu;
        final courseId = course.id;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => getIt<LessonsCubit>()..fetchLessons(courseId!),
                child: LessonsList(course_details: course),
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
      //--------------------------------------------------------

      case Routes.teacher_lessons_flashcards:
        final lessonId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<TeacherLessonFlashcardsCubit>()
                          ..fetchLessonFlashcards(lessonId),
                child: TeacherLessonFlashcardsScreen(lessonId: lessonId),
              ),
        );
      //--------------------------------------------------------

      case Routes.course_flashcards_screen:
        final courseId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<CourseFlashcardsCubit>()
                          ..fetchLessonFlashcards(courseId),
                child: CourseFlashcardsScreen(courseId: courseId),
              ),
        );
      //--------------------------------------------------------

      case Routes.course_students_screen:
        final courseId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<GetStudentsNamesCubit>()
                          ..fetchStudentsNames(courseId),
                child: CourseStudentsScreen(courseId: courseId),
              ),
        );
      //--------------------------------------------------------

      case Routes.teacher_selftests_screen:
        final lessonId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<SelfTestsCubit>()..fetchSelfTests(lessonId),
                child: TeacherSelfTestsScreen(lessonId: lessonId),
              ),
        );
      //--------------------------------------------------------
      case Routes.stu_lesson_screen:
        final lesson = settings.arguments as Lesson;
        return MaterialPageRoute(
          builder: (_) => StuLessonScreen(lesson_details: lesson),
        );

      //--------------------------------------------------------
      case Routes.lessons_flashcards:
        final lessonId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<LessonFlashcardsCubit>()
                          ..fetchLessonFlashcards(lessonId),
                child: LessonFlashcardsScreen(lessonId: lessonId),
              ),
        );
      //--------------------------------------------------------

      case Routes.selftests_screen:
        final lessonId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<SelfTestsCubit>()..fetchSelfTests(lessonId),
                child: SelfTestsScreen(lessonId: lessonId),
              ),
        );
      //--------------------------------------------------------

      case Routes.stu_selftest_details:
        final selfTest = settings.arguments as SelfTests;
        return MaterialPageRoute(
          builder: (_) => StuSelfTestDetails(selfTest: selfTest),
        );

          //----------------------------------------------------------

        case Routes.private_course:
  return MaterialPageRoute(
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider<PrivateCourseCubit>(
          create: (_) => getIt<PrivateCourseCubit>()..fetchPC(),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) => getIt<LanguageCubit>()..fetchLanguages(),
        ),
      ],
      child: const PrivateCourseScreen(),
    ),
  );
      //--------------------------------------------------------

      case Routes.languages_list:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) =>
                        LanguageCubit(getIt<GetLanguageUsecase>())
                          ..fetchLanguages(),
                child: LmcInfoScreen(),
              ),
        );

      //----------------------------------------------------------

      case Routes.languages_have_library:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) => LanguagesHaveLibraryCubit(
                      getIt<GetLanguagesHaveLibraryUsecase>(),
                    )..fetchLanguages(),
                child: LanguagesHaveLibraryScreen(),
              ),
        );

      //--------------------------------------------------------

      case Routes.add_selftest_question:
        final selfTest = settings.arguments as SelfTests;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddSelfTestQuestionCubit>(),
                child: AddSelftestQuestionScreen(selfTest: selfTest),
              ),
        );
      //--------------------------------------------------------
      case Routes.send_task_to_sec:
        final lesson = settings.arguments as TeacherLessons;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SendTaskToSecCubit>(),
                child: SendTaskToSecScreen(lesson: lesson),
              ),
        );
      //--------------------------------------------------------
      //Teacher Complaints

      case Routes.my_complaints:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<MyComplaintsCubit>(),
                child: MyComplaintsScreen(),
              ),
        );

      case Routes.submit_complaint:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SubmitComplaintCubit>(),
                child: SubmitComplaintScreen(),
              ),
        );

      case Routes.edit_complaint:
        final args = settings.arguments as Map<String, dynamic>;
        final complaintId = args['complaintId'] as String;
        final subject = args['subject'] as String;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<EditComplaintCubit>(),
                child: EditComplaintScreen(
                  complaintId: complaintId,
                  subject: subject,
                ),
              ),
        );

      //--------------------------------------------------------
      case Routes.teacher_selftests_details:
        final selfTest = settings.arguments as SelfTests;
        return MaterialPageRoute(
          builder: (_) => TeacherSelfTestDetails(selfTest: selfTest),
        );
      //--------------------------------------------------------
      case Routes.calendar_screen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ShowScheduleCubit>(),
                child: TeacherCalendarScreen(),
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

      //---------------------------------------------------------

      case Routes.student_my_courses:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<StudentMyCoursesCubit>(),
                child: StudentMyCoursesScreen(),
              ),
        );

      //----------------------------------------------------------
      case Routes.teacher_lessons_details:
        final lesson = settings.arguments as dynamic;
        return MaterialPageRoute(
          builder: (_) => TeacherLessonDetails(lesson_details: lesson),
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

      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.add_flashcard:
        final lessonId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddFlashcardCubit>(),
                child: AddFlashcardScreen(lessonId: lessonId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.add_selftest:
        final lessonId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddSelfTestCubit>(),
                child: AddSelfTestScreen(lessonId: lessonId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.add_final_test_screen:
        final courseId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddFinalTestCubit>(),
                child: AddFinalTestScreen(courseId: courseId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.teacher_final_test_screen:
        final courseId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<GetTeacherFinalTestCubit>(),
                child: TeacherFinalTestScreen(courseId: courseId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.teacher_final_test_details_screen:
        final testId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<GetTeacherFinalTestQuestionsCubit>(),
                child: TeacherFinalTestDetailsScreen(testId: testId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.add_final_test_question:
        final testId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddFinalTestQuestionCubit>(),
                child: AddSelftestQuestionScreenFT(testId: testId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.edit_flashcard:
        final args = settings.arguments as Map<String, Object?>;
        final lessonId = args['lessonId'] as int;
        final flashcardId = args['flashcardId'] as int;
        final oldContent = args['oldContent'] as String;
        final oldTranslation = args['oldTranslation'] as String;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<EditFlashcardCubit>(),
                child: EditFlashcardScreen(
                  lessonId: lessonId,
                  flashcardId: flashcardId,
                  oldContent: oldContent,
                  oldTranslation: oldTranslation,
                ),
              ),
        );
      //----------------------------------------------------------

      case Routes.lmc_info:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) =>
                        LmcInfoCubit(getIt<GetLmcInfoUsecase>())
                          ..fetchLmcInfo(),
                child: LmcInfoScreen(),
              ),
        );

        //----------------------------------------------------------

      case Routes.holidays_screen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) =>
                        HolidaysCubit(getIt<GetHolidaysUsecase>())
                          ..fetchHolidays(),
                child: HolidaysScreen(),
              ),
        );


      //----------------------------------------------------------

      case Routes.my_profile:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) =>
                        MyProfileCubit(getIt<GetMyProfileUsecase>(), getIt<EditMyInfoUsecase>())
                          ..fetchMyInfo(),
                child: MyProfileScreen(),
              ),
        );

           //----------------------------------------------------------

        
        case Routes.lang_files:
        final languagesHaveLIbrary = settings.arguments as LanguagesHaveLibrary;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
            create: (_) => LangFilesCubit(getIt<GetLangFilesUsecase>())..fetchFiles(languagesHaveLIbrary.id!),
            child: LangFilesScreen(languagesHaveLibrary: languagesHaveLIbrary,),
          ),
        );



      //----------------------------------------------------------

      case Routes.languages_list:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) =>
                        LanguageCubit(getIt<GetLanguageUsecase>())
                          ..fetchLanguages(),
                child: LmcInfoScreen(),
              ),
        );

      //----------------------------------------------------------

      case Routes.attendance_and_marks_screen:
        final lesson = settings.arguments as TeacherLessons;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) =>
                            getIt<GetStudentsNamesCubit>()
                              ..fetchStudentsNames(lesson.id!),
                  ),
                  BlocProvider(
                    create: (context) => getIt<MarkAttendanceCubit>(),
                  ),
                  BlocProvider(create: (context) => getIt<EnterBonusCubit>()),
                ],
                child: AttendanceAndMarksScreen(lesson: lesson),
              ),
        );

              // --------------------------------------------------------------------------------------------------------------------------
      case Routes.add_final_test_screen:
        final courseId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddFinalTestCubit>(),
                child: AddFinalTestScreen(courseId: courseId),
              ),
        );

         // --------------------------------------------------------------------------------------------------------------------------
      case Routes.teacher_final_test_screen:
        final courseId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<GetTeacherFinalTestCubit>(),
                child: TeacherFinalTestScreen(courseId: courseId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.teacher_final_test_details_screen:
        final testId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<GetTeacherFinalTestQuestionsCubit>(),
                child: TeacherFinalTestDetailsScreen(testId: testId),
              ),
        );
      // --------------------------------------------------------------------------------------------------------------------------
      case Routes.add_final_test_question:
        final testId = settings.arguments as int;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddFinalTestQuestionCubit>(),
                child: AddSelftestQuestionScreenFT(testId: testId),
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

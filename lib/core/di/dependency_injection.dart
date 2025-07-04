import 'package:get_it/get_it.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/add_flashcard/logic/cubit/add_flashcard_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/add_flashcard/logic/usecase/add_flashcard_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/edit_flashcard/logic/cubit/edit_flashcard_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/edit_flashcard/logic/usecase/edit_flashcard_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/logic/cubit/teacher_lesson_flashcard_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/logic/usecase/taecher_lesson_flashcards_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest/logic/cubit/add_selftest_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest/logic/usecase/add_selftests_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/logic/cubit/add_selftest_question_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/logic/usecase/add_selftest_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/logic/cubit/selftests_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/logic/usecase/selftest_usecase.dart';
import '../../features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import '../../features/for_all/announsments/logic/usecases/get_all_announcements_usecase.dart';
import '../../features/for_all/available_courses/logic/cubit/cubit/available_courses_cubit.dart';
import '../../features/for_all/available_courses/logic/usecases/available_courses_usecase.dart';
import '../../features/for_all/login/logic/cubit/login_cubit.dart';
import '../../features/for_all/login/logic/usecases/login_usecases.dart';
import '../../features/for_all/signup/logic/cubit/signup_cubit.dart';
import '../../features/for_all/signup/logic/usecases/signup_usecases.dart';
import '../../features/logistic_features/send_invoice/logic/cubit/send_invoice_cubit.dart';
import '../../features/logistic_features/send_invoice/logic/usecase/send_invoice_usecase.dart';
import '../../features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import '../../features/logistic_features/show_tasks/logic/usecases/all_tasks_usecases.dart';
import '../../features/student_features/my_courses/show_lessons/logic/cubit/lessons_cubit.dart';
import '../../features/student_features/my_courses/show_lessons/logic/usecases/lessons_usescase.dart';
import '../../features/student_features/my_courses/show_my_courses/logic/cubit/student_my_courses_cubit.dart';
import '../../features/student_features/my_courses/show_my_courses/logic/usecases/student_my_courses_usecase.dart';
import '../../features/student_features/show_teachers/logic/cubit/show_teachers_cubit.dart';
import '../../features/student_features/show_teachers/logic/usecases/get_teachers_list.dart';
import '../../features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_cubit.dart';
import '../../features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/usecases/teacher_lessons_usescase.dart';
import '../../features/teacher_features/teacher_courses_management/teacher_courses/logic/cubit/my_courses_teacher_cubit.dart';
import '../../features/teacher_features/teacher_courses_management/teacher_courses/logic/usecases/my_courses_teacher_usecase.dart';
import '../networking/api_service.dart';
import 'shared_pref.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Existing registrations
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => LocalStorage());

  getIt.registerLazySingleton(
    () => LoginUseCase(getIt<ApiService>(), getIt<LocalStorage>()),
  );
  getIt.registerFactory(() => LoginCubit(getIt<LoginUseCase>()));

  getIt.registerLazySingleton(
    () => SignupUseCase(getIt<ApiService>(), getIt<LocalStorage>()),
  );
  getIt.registerFactory(() => signupCubit(getIt<SignupUseCase>()));

  // New registrations for announcements
  getIt.registerLazySingleton(
    () => GetAllAnnouncementsUseCase(
      getIt<ApiService>(),
    ), // Register the use case
  );
  getIt.registerFactory(
    () => AllAnnouncementsCubit(
      getIt<GetAllAnnouncementsUseCase>(),
    ), // Register the cubit
  );
  getIt.registerLazySingleton(
    () => GetAllTasksUseCase(getIt<ApiService>()), // Register the use case
  );
  getIt.registerFactory(
    () => AllTasksCubit(getIt<GetAllTasksUseCase>()), // Register the cubit
  );

  getIt.registerLazySingleton(
    () => GetAvailableCoursesUseCase(
      getIt<ApiService>(),
    ), // Register the use case
  );
  getIt.registerFactory(
    () => AvailableCoursesCubit(
      getIt<GetAvailableCoursesUseCase>(),
    ), // Register the cubit
  );
  getIt.registerLazySingleton(() => SendInvoiceUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => SendInvoiceCubit(getIt<SendInvoiceUseCase>()));

  getIt.registerLazySingleton(
    () => GetMyCoursesTeacherUseCase(
      getIt<ApiService>(),
    ), // Register the use case
  );
  getIt.registerFactory(
    () => MyCoursesTeacherCubit(
      getIt<GetMyCoursesTeacherUseCase>(),
    ), // Register the cubit
  );

  ///----------------------------------------------------------------

  getIt.registerLazySingleton(
    () => GetLessonsUsecase(getIt<ApiService>()), // Register the use case
  );
  getIt.registerFactory(
    () => LessonsCubit(getIt<GetLessonsUsecase>()), // Register the cubit
  );

  ///----------------------------------------------------------------

  getIt.registerLazySingleton(
    () =>
        GetTeacherLessonsUsecase(getIt<ApiService>()), // Register the use case
  );
  getIt.registerFactory(
    () => TeacherLessonsCubit(
      getIt<GetTeacherLessonsUsecase>(),
    ), // Register the cubit
  );
  //===============================================================================
  getIt.registerLazySingleton(
    () => GetTeachersListUsecase(getIt<ApiService>()), // Register the use case
  );
  getIt.registerFactory(
    () => ShowTeachersCubit(
      getIt<GetTeachersListUsecase>(),
    ), // Register the cubit
  );
  //===============================================================================
  getIt.registerLazySingleton(
    () => TeacherLessonFlashcardsUsecase(
      getIt<ApiService>(),
    ), // Register the use case
  );
  getIt.registerFactory(
    () => TeacherLessonFlashcardsCubit(
      getIt<TeacherLessonFlashcardsUsecase>(),
    ), // Register the cubit
  );

  //===============================================================================

  getIt.registerLazySingleton(() => AddFlashcardUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => AddFlashcardCubit(getIt<AddFlashcardUseCase>()));

  //===============================================================================

  getIt.registerLazySingleton(() => EditFlashcardUseCase(getIt<ApiService>()));
  getIt.registerFactory(
    () => EditFlashcardCubit(getIt<EditFlashcardUseCase>()),
  );

  //===============================================================================

  getIt.registerLazySingleton(() => SelfTestsUsecase(getIt<ApiService>()));
  getIt.registerFactory(() => SelfTestsCubit(getIt<SelfTestsUsecase>()));

  //===============================================================================

  getIt.registerLazySingleton(() => AddSelfTestsUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => AddSelfTestCubit(getIt<AddSelfTestsUseCase>()));

  //===============================================================================

  getIt.registerLazySingleton(() => AddSelfTestQuestionsUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => AddSelfTestQuestionCubit(getIt<AddSelfTestQuestionsUseCase>()));

  //===============================================================================

  getIt.registerLazySingleton(
    () => GetStudentMyCoursesUsecase(
      getIt<ApiService>(),
    ), // Register the use case
  );
  getIt.registerFactory(
    () => StudentMyCoursesCubit(
      getIt<GetStudentMyCoursesUsecase>(),
    ), // Register the cubit
  );
}

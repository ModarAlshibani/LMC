import 'package:get_it/get_it.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/announsments/logic/usecases/get_all_announcements_usecase.dart';
import 'package:lmc_app/features/for_all/available_courses/logic/cubit/cubit/available_courses_cubit.dart';
import 'package:lmc_app/features/for_all/available_courses/logic/usecases/available_courses_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/cubit/holidays_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/usecases/get_holidays_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/cubit/language_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/usecases/language_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/cubit/lang_files_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/usecases/lang_files_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/cubit/languages_have_library_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/usecases/languages_have_library_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/cubit/lmc_info_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/logic/usecases/lmc_info_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/usecases/edit_my_profile_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/usecases/my_profile_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/cubit/private_course_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/add_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/delete_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/edit_private_course_usecase.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/usecases/get_private_course_usecase.dart';
import 'package:lmc_app/features/logistic_features/send_invoice/logic/cubit/send_invoice_cubit.dart';
import 'package:lmc_app/features/logistic_features/send_invoice/logic/usecase/send_invoice_usecase.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/usecases/all_tasks_usecases.dart';
import 'package:lmc_app/features/for_all/signup/logic/cubit/signup_cubit.dart';
import 'package:lmc_app/features/for_all/signup/logic/usecases/signup_usecases.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/logic/cubit/lessons_cubit.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/logic/usecases/lessons_usescase.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/logic/cubit/stu_flashcard_cubit.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/logic/usecases/stu_flashcard_usecase.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/logic/cubit/student_my_courses_cubit.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/logic/usecases/student_my_courses_usecase.dart';
import 'package:lmc_app/features/student_features/show_teachers/logic/cubit/show_teachers_cubit.dart';
import 'package:lmc_app/features/student_features/show_teachers/logic/usecases/get_teachers_list.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/enter_bonus_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/get_students_names_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/mark_attendance_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/usecases/enter_bonus_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/usecases/get_students_names_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/usecases/mark_attendance_usecase.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/send_task_to_sec/logic/cubit/send_task_to_sec_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/send_task_to_sec/logic/usecase/send_task_to_sec_usecase.dart';
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
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/cubit/edit_complaint_cubit.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/cubit/my_complaints_cubit.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/cubit/submit_complaint_cubit.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/edit_complaint_usecase.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/my_complaints_usecase.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/submit_complaints_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/logic/cubit/course_flashcards_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/logic/usecase/course_flashcards_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/add_final_test_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/add_final_test_question_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/get_final_test_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/get_final_test_questions_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/add_final_test_question_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/add_final_test_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/get_final_test_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/get_teacher_final_test_questions_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/usecases/teacher_lessons_usescase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/logic/cubit/my_courses_teacher_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/logic/usecases/my_courses_teacher_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/logic/cubit/show_schedule_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/logic/usecases/show_schedule_usecase.dart';

import '../../features/for_all/login/logic/cubit/login_cubit.dart';
import '../../features/for_all/login/logic/usecases/login_usecases.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Core services
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => LocalStorage());

  // Authentication
  getIt.registerLazySingleton(
    () => LoginUseCase(getIt<ApiService>(), getIt<LocalStorage>()),
  );
  getIt.registerFactory(() => LoginCubit(getIt<LoginUseCase>()));

  getIt.registerLazySingleton(
    () => SignupUseCase(getIt<ApiService>(), getIt<LocalStorage>()),
  );
  getIt.registerFactory(() => signupCubit(getIt<SignupUseCase>()));

  // Announcements
  getIt.registerLazySingleton(
    () => GetAllAnnouncementsUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => AllAnnouncementsCubit(getIt<GetAllAnnouncementsUseCase>()),
  );

  // Tasks
  getIt.registerLazySingleton(
    () => GetAllTasksUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => AllTasksCubit(getIt<GetAllTasksUseCase>()),
  );

  // Available Courses
  getIt.registerLazySingleton(
    () => GetAvailableCoursesUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => AvailableCoursesCubit(getIt<GetAvailableCoursesUseCase>()),
  );

  // Send Invoice
  getIt.registerLazySingleton(() => SendInvoiceUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => SendInvoiceCubit(getIt<SendInvoiceUseCase>()));

  // Teacher Courses
  getIt.registerLazySingleton(
    () => GetMyCoursesTeacherUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => MyCoursesTeacherCubit(getIt<GetMyCoursesTeacherUseCase>()),
  );

  // Student Lessons
  getIt.registerLazySingleton(
    () => GetLessonsUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => LessonsCubit(getIt<GetLessonsUsecase>()),
  );

  // Teacher Lessons
  getIt.registerLazySingleton(
    () => GetTeacherLessonsUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => TeacherLessonsCubit(getIt<GetTeacherLessonsUsecase>()),
  );

  // Teachers List
  getIt.registerLazySingleton(
    () => GetTeachersListUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => ShowTeachersCubit(getIt<GetTeachersListUsecase>()),
  );

  // Teacher Flashcards
  getIt.registerLazySingleton(
    () => TeacherLessonFlashcardsUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => TeacherLessonFlashcardsCubit(getIt<TeacherLessonFlashcardsUsecase>()),
  );

  // Student Flashcards
  getIt.registerLazySingleton(
    () => LessonFlashcardsUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => LessonFlashcardsCubit(getIt<LessonFlashcardsUsecase>()),
  );

  // Course Flashcards
  getIt.registerLazySingleton(
    () => CourseFlashcardsUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => CourseFlashcardsCubit(getIt<CourseFlashcardsUsecase>()),
  );

  // Teacher Schedule
  getIt.registerLazySingleton(
    () => GetShowScheduleUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => ShowScheduleCubit(getIt<GetShowScheduleUseCase>()),
  );

  // Flashcard Management
  getIt.registerLazySingleton(() => AddFlashcardUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => AddFlashcardCubit(getIt<AddFlashcardUseCase>()));

  getIt.registerLazySingleton(() => EditFlashcardUseCase(getIt<ApiService>()));
  getIt.registerFactory(
    () => EditFlashcardCubit(getIt<EditFlashcardUseCase>()),
  );

  // Self Tests
  getIt.registerLazySingleton(() => SelfTestsUsecase(getIt<ApiService>()));
  getIt.registerFactory(() => SelfTestsCubit(getIt<SelfTestsUsecase>()));

  getIt.registerLazySingleton(() => AddSelfTestsUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => AddSelfTestCubit(getIt<AddSelfTestsUseCase>()));

  getIt.registerLazySingleton(
    () => AddSelfTestQuestionsUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => AddSelfTestQuestionCubit(getIt<AddSelfTestQuestionsUseCase>()),
  );

  // Send Task to Secretary
  getIt.registerLazySingleton(
    () => SendTaskToSecStateUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => SendTaskToSecCubit(getIt<SendTaskToSecStateUseCase>()),
  );

  // Student Courses
  getIt.registerLazySingleton(
    () => GetStudentMyCoursesUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => StudentMyCoursesCubit(getIt<GetStudentMyCoursesUsecase>()),
  );

  // LMC Info
  getIt.registerLazySingleton(
    () => GetLmcInfoUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => LmcInfoCubit(getIt<GetLmcInfoUsecase>()),
  );

   // Holidays
  getIt.registerLazySingleton(
    () => GetHolidaysUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => HolidaysCubit(getIt<GetHolidaysUsecase>()),
  );

  // Languages Have Library
  getIt.registerLazySingleton(
    () => GetLanguagesHaveLibraryUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => LanguagesHaveLibraryCubit(getIt<GetLanguagesHaveLibraryUsecase>()),
  );

  // // Private Course
  // getIt.registerLazySingleton(
  //   () => GetPrivateCourseUsecase(getIt<ApiService>()),
  // );
  // getIt.registerFactory(
  //   () => PrivateCourseCubit(getIt<GetPrivateCourseUsecase>()),
  // );

  // Language Files
  getIt.registerLazySingleton(
    () => GetLangFilesUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => LangFilesCubit(getIt<GetLangFilesUsecase>()),
  );

  // Profile
  getIt.registerLazySingleton(
    () => GetMyProfileUsecase(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<EditMyInfoUsecase>(
  () => EditMyInfoUsecase(getIt<ApiService>()),
);
  getIt.registerFactory(
    () => MyProfileCubit(getIt<GetMyProfileUsecase>(), getIt<EditMyInfoUsecase>()),
  );
  

  // Attendance and Marks
  getIt.registerLazySingleton(() => MarkAttendanceUseCase(getIt<ApiService>()));
  getIt.registerFactory(
    () => MarkAttendanceCubit(getIt<MarkAttendanceUseCase>()),
  );

  getIt.registerLazySingleton(() => EnterBonusUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => EnterBonusCubit(getIt<EnterBonusUseCase>()));

  getIt.registerLazySingleton(
    () => GetStudentsNamesUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => GetStudentsNamesCubit(getIt<GetStudentsNamesUsecase>()),
  );

  // Complaints
  getIt.registerLazySingleton(
    () => SubmitComplaintUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => SubmitComplaintCubit(getIt<SubmitComplaintUseCase>()),
  );

  getIt.registerLazySingleton(() => EditComplaintUseCase(getIt<ApiService>()));
  getIt.registerFactory(
    () => EditComplaintCubit(getIt<EditComplaintUseCase>()),
  );

  getIt.registerLazySingleton(() => MyComplaintsUsecase(getIt<ApiService>()));
  getIt.registerFactory(() => MyComplaintsCubit(getIt<MyComplaintsUsecase>()));

  // Final Tests
  getIt.registerLazySingleton(() => AddFinalTestUseCase(getIt<ApiService>()));
  getIt.registerFactory(() => AddFinalTestCubit(getIt<AddFinalTestUseCase>()));

  getIt.registerLazySingleton(
    () => GetTeacherFinalTestUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => GetTeacherFinalTestCubit(getIt<GetTeacherFinalTestUsecase>()),
  );

  getIt.registerLazySingleton(
    () => AddFinalTestQuestionsUseCase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => AddFinalTestQuestionCubit(getIt<AddFinalTestQuestionsUseCase>()),
  );

  getIt.registerLazySingleton(
    () => GetTeacherFinalTestQuestionsUsecase(getIt<ApiService>()),
  );
  getIt.registerFactory(
    () => GetTeacherFinalTestQuestionsCubit(
      getIt<GetTeacherFinalTestQuestionsUsecase>(),
    ),
  );

  
  // Private Course registrations (FIXED VERSION):
  getIt.registerLazySingleton(
    () => GetPrivateCourseUsecase(getIt<ApiService>()),
  );
  
  getIt.registerLazySingleton(
    () => AddPrivateCourseUsecase(getIt<ApiService>()),
  );
  
  getIt.registerLazySingleton(
    () => UpdatePrivateCourseUsecase(getIt<ApiService>()),
  );
  
  getIt.registerLazySingleton(
    () => DeletePrivateCourseUsecase(getIt<ApiService>()),
  );

  getIt.registerLazySingleton(() => GetLanguageUsecase(getIt<ApiService>()));
  
  getIt.registerFactory(() => LanguageCubit(getIt<GetLanguageUsecase>()));
  getIt.registerFactory(
    () => PrivateCourseCubit(
      getPrivateCourseUsecase: getIt<GetPrivateCourseUsecase>(),
      addPrivateCourseUsecase: getIt<AddPrivateCourseUsecase>(),
      updatePrivateCourseUsecase: getIt<UpdatePrivateCourseUsecase>(),
      deletePrivateCourseUsecase: getIt<DeletePrivateCourseUsecase>(),
    ),
  );

}
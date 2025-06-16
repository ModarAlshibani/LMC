import 'package:get_it/get_it.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/for_all/announsments/logic/usecases/get_all_announcements_usecase.dart';
import 'package:lmc_app/features/for_all/courses/data/models/available_courses_model.dart';
import 'package:lmc_app/features/for_all/courses/logic/cubit/cubit/available_courses_cubit.dart';
import 'package:lmc_app/features/for_all/courses/logic/usecases/available_courses_usecase.dart';
import 'package:lmc_app/features/logistic_features/send_invoice/logic/cubit/send_invoice_cubit.dart';
import 'package:lmc_app/features/logistic_features/send_invoice/logic/usecase/send_invoice_usecase.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/usecases/all_tasks_usecases.dart';
import 'package:lmc_app/features/for_all/signup/logic/cubit/signup_cubit.dart';
import 'package:lmc_app/features/for_all/signup/logic/usecases/signup_usecases.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses/logic/cubit/my_courses_teacher_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses/logic/usecases/my_courses_teacher_usecase.dart';

import '../../features/for_all/login/logic/cubit/login_cubit.dart';
import '../../features/for_all/login/logic/usecases/login_usecases.dart';

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
}

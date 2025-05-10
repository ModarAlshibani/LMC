import 'package:get_it/get_it.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/announsments/logic/cubit/all_announcements_cubit.dart';
import 'package:lmc_app/features/announsments/logic/usecases/get_all_announcements_usecase.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/logic/usecases/all_tasks_usecases.dart';
import 'package:lmc_app/features/signup/logic/cubit/signup_cubit.dart';
import 'package:lmc_app/features/signup/logic/usecases/signup_usecases.dart';

import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/logic/usecases/login_usecases.dart';

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
}

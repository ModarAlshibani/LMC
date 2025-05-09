// service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/signup/logic/cubit/signup_cubit.dart';
import 'package:lmc_app/features/signup/logic/usecases/signup_usecases.dart';

import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/logic/usecases/login_usecases.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
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
}

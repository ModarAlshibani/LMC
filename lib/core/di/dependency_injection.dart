// service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/core/networking/api_service.dart';

import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/logic/usecases/login_usecases.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Registering services and use cases
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => LocalStorage());  // Register LocalStorage

  // Register the LoginUseCase with its dependencies
  getIt.registerLazySingleton(() => LoginUseCase(getIt<ApiService>(), getIt<LocalStorage>()));

  // Register the LoginCubit as a factory (it will be created when needed)
  getIt.registerFactory(() => LoginCubit(getIt<LoginUseCase>()));
}

// lib/features/placement_test/logic/placement_test_di.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/cubit/placement_test_cubit.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/usecases/get_next_question_usecase.dart';
import 'package:lmc_app/features/for_all/placement_tests/logic/usecases/submit_answer_usecase.dart';
import 'placement_test_api.dart';
import 'placement_test_repository.dart';

final getIt = GetIt.instance;

void setupPlacementTestDependencies() {
  // Dio instance
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() => Dio());
  }

  // API
  getIt.registerLazySingleton<PlacementTestApi>(
    () => PlacementTestApi(getIt<Dio>()),
  );

  // Repository
  getIt.registerLazySingleton<PlacementTestRepository>(
    () => PlacementTestRepositoryImpl(getIt<PlacementTestApi>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetNextQuestionUseCase>(
    () => GetNextQuestionUseCase(getIt<PlacementTestRepository>()),
  );

  getIt.registerLazySingleton<SubmitAnswerUseCase>(
    () => SubmitAnswerUseCase(getIt<PlacementTestRepository>()),
  );

  // Cubit
  getIt.registerFactory<PlacementTestCubit>(
    () => PlacementTestCubit(
      getNextQuestionUseCase: getIt<GetNextQuestionUseCase>(),
      submitAnswerUseCase: getIt<SubmitAnswerUseCase>(),
    ),
  );
}

// Helper function to get PlacementTestCubit instance
PlacementTestCubit getPlacementTestCubit() => getIt<PlacementTestCubit>();
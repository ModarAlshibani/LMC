import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/networking/dio_factory.dart';
import 'package:lmc_app/features/login/data/repos/login_repo.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';

final get_it = GetIt.instance;
Future<void> setupGetIt() async {
  //dio
  Dio dio =  DioFactory.getDio();
  get_it.registerSingleton<ApiService>(ApiService(dio));

//login
get_it.registerSingleton<LoginRepo>(LoginRepo(get_it()));
get_it.registerSingleton<LoginCubit>(LoginCubit(get_it()));
}
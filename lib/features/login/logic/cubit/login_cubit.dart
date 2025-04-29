// presentation/cubit/login_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/login_response.dart';
import '../usecases/login_usecases.dart';
// Import LoginModel

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final loginData = await loginUseCase.execute(username, password);
      final token = loginData.token;
      final user = loginData.user;

      // Emit LoginSuccess with token and user
      emit(LoginSuccess(token: token, user: user));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}

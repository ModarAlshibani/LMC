import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:lmc_app/features/login/data/models/login_request_body.dart';
import 'package:lmc_app/features/login/data/models/login_response.dart';
import 'package:lmc_app/features/login/data/repos/login_repo.dart';
import 'package:lmc_app/features/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(loginRequestBody);
    response.when(
      success: (loginResponse) {
        emit(LoginState.success(loginResponse));
      },
      failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message ?? "nnn"));
      },
    );
  }
}

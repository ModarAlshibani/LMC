import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit, ReadContext;
import 'package:lmc_app/core/networking/dio_factory.dart';
import 'package:lmc_app/features/login/data/models/login_request_body.dart';
import 'package:lmc_app/features/login/data/models/login_response.dart';
import 'package:lmc_app/features/login/data/repos/login_repo.dart';
import 'package:lmc_app/features/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading()); // Emit loading state
    try {
      final response = await _loginRepo.login(
        LoginRequestBody(
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      response.when(
        success: (LoginResponse data) {
          // Emit success state with the token
          emit(LoginState.success(data.token!));
        },
        failure: (error) {
          // Emit failure state with the error message
          emit(LoginState.error(error: error.apiErrorModel.message!));
        },
      );
    } catch (error) {
      emit(LoginState.error(error: "An error occurred: $error"));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/for_all/login/logic/cubit/logout_state.dart';
import 'package:lmc_app/features/for_all/login/logic/usecases/logout_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final LogoutUseCase logoutUseCase;

  AuthCubit(this.logoutUseCase) : super(AuthInitial());

  Future<void> logOut() async {
    emit(AuthLoggingOut());
    try {
      await logoutUseCase();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthLogoutFailed(e.toString()));
    }
  }
}

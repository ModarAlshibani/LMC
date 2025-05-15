import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/networking/network_error_handler.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../data/models/login_response.dart';
import '../usecases/login_usecases.dart'; // Import to access BuildContext

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final formKey = GlobalKey<FormState>(); // Global key for the form to validate

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    if (email.isEmpty && password.isEmpty) {
      emit(LoginFailure(error: 'Email and Password are required.'));
      _showDialog(
        context,
        'Email and Password are required.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }
    if (email.isEmpty) {
      emit(LoginFailure(error: 'Email cannot be empty.'));
      _showDialog(
        context,
        'Email cannot be empty.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }

    // التحقق من صحة المدخلات قبل محاولة الإرسال
    if (Validators.isValidEmail(email) == false) {
      emit(LoginFailure(error: 'Please enter a valid email address.'));
      _showDialog(
        context,
        'Please enter a valid email address.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }

    if (password.isEmpty) {
      emit(LoginFailure(error: 'Password cannot be empty.'));
      _showDialog(
        context,
        'Password cannot be empty.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }

    emit(LoginLoading());

    try {
      // إرسال طلب تسجيل الدخول
      final loginData = await loginUseCase.execute(email, password, context);
      emit(LoginSuccess(token: loginData.token, user: loginData.user));
    } catch (error) {
      NetworkErrorHandler.handleError(error, context); // معالجة الخطأ
      emit(LoginFailure(error: error.toString()));
    }
  }

  // دالة لعرض الـ Dialog
  void _showDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: GlassContainer(
            width: 350,
            height: 250,
            topLeft: 15,
            topRight: 15,
            bottomRight: 15,
            bottomLeft: 15,
            firstColor: AppColors.lmcOrange,
            secondColor: AppColors.backgroundColor,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    errorMessage,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // إغلاق الـ Dialog
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lmcOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 80.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

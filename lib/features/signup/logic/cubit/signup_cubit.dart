import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/validators.dart';
import 'package:lmc_app/core/networking/network_error_handler.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/signup/data/signup_response.dart';
import 'package:lmc_app/features/signup/logic/usecases/signup_usecases.dart';



part 'signup_state.dart';

class signupCubit extends Cubit<signupState> {
  final SignupUseCase signupUseCase;
  final formKey = GlobalKey<FormState>(); 

  signupCubit(this.signupUseCase) : super(signupInitial());

  Future<void> signup(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    if (email.isEmpty && password.isEmpty && name.isEmpty) {
      emit(signupFailure(error: 'Email, Password and name are required.'));
      _showDialog(
        context,
        'Email, Password and name are required.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }
    if (email.isEmpty) {
      emit(signupFailure(error: 'Email cannot be empty.'));
      _showDialog(
        context,
        'Email cannot be empty.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }
    if (password.isEmpty) {
      emit(signupFailure(error: 'Password cannot be empty.'));
      _showDialog(
        context,
        'Password cannot be empty.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }
    if (name.isEmpty) {
      emit(signupFailure(error: 'Name cannot be empty.'));
      _showDialog(
        context,
        'Name cannot be empty.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }

    // التحقق من صحة المدخلات قبل محاولة الإرسال
    if (Validators.isValidEmail(email) == false) {
      emit(signupFailure(error: 'Please enter a valid email address.'));
      _showDialog(
        context,
        'Please enter a valid email address.',
      ); // استخدام Dialog بدلاً من Snackbar
      return;
    }

    if (Validators.hasMinLength(password) == false) {
      emit(signupFailure(error: 'Password should be at least 8 characters.'));
      _showDialog(
        context,
        'Password should be at least 8 characters.',
      );
      return;
    }

    if (Validators.hasUpperCase(password) == false) {
      emit(signupFailure(error: 'Password should contain at least one uppercase letter.'));
      _showDialog(
        context,
        'Password should contain at least one uppercase letter.',
      );
      return;
    }

    if (Validators.hasLowerCase(password) == false) {
      emit(signupFailure(error: 'Password should contain at least one lowercase letter.'));
      _showDialog(
        context,
        'Password should contain at least one lowercase letter.',
      );
      return;
    }
     if (Validators.hasNumber(password) == false) {
       emit(signupFailure(error: 'Password should contain at least one number.'));
       _showDialog(
         context,
         'Password should contain at least one number.',
       );
       return;
     }
     if (Validators.hasSpecialCharacter(password) == false) {
       emit(signupFailure(error: 'Password should contain at least one special character.'));
       _showDialog(
         context,
         'Password should contain at least one special character.',
       );
       return;
     }



    emit(signupLoading());

    try {
      // إرسال طلب تسجيل الدخول
      final signupData = await signupUseCase.execute(name, email, password, context);
      emit(signupSuccess(token: signupData.token, user: signupData.user));
    } catch (error) {
      NetworkErrorHandler.handleError(error, context); // معالجة الخطأ
      emit(signupFailure(error: error.toString()));
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

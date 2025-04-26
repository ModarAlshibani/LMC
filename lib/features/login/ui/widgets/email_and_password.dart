import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  
  bool isObsecureText = true;

  late TextEditingController emailController;
  late TextEditingController passwordController;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = context.read<LoginCubit>().emailController;
    passwordController = context.read<LoginCubit>().passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          GeneralTextFormField(
            controller: context.read<LoginCubit>().emailController,
            validator: (value){
              if(value == null || value.isEmpty){
                return "Email is required";
              }
            },
            hintText: "Email@gmail.com",
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 20.sp,
              color: AppColors.greyBorder,
            ),
          ),
          verticalSpace(10.h),
          GeneralTextFormField(
            controller: context.read<LoginCubit>().passwordController,
            validator: (value){
              if(value == null || value.isEmpty){
                return "Password is required";
              }
            },
            hintText: "********",
            isObsecureText: isObsecureText,
            prefixIcon: Icon(
              Icons.vpn_key_outlined,
              size: 20,
              color: AppColors.greyBorder,
            ),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => isObsecureText = !isObsecureText),
              child: Icon(
                isObsecureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: AppColors.greyBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

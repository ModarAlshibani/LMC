import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/App_button.dart';
import '../../../../../core/widgets/general_text_form_field.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../../guest_features/guest_homePage/ui/widgets/top_container.dart';
import '../../logic/cubit/send_invoice_cubit.dart';

class SendInvoiceScreen extends StatefulWidget {
  final int taskId;
  final String content;
  const SendInvoiceScreen({
    Key? key,
    required this.taskId,
    required this.content,
  }) : super(key: key);

  @override
  State<SendInvoiceScreen> createState() => _SendInvoiceScreenState();
}

class _SendInvoiceScreenState extends State<SendInvoiceScreen> {
  final TextEditingController _amountController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitInvoice(BuildContext context) {
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText);

    if (amount == null || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Amount and Photo can't be empty!")),
      );
      return;
    }

    context.read<SendInvoiceCubit>().sendInvoice(
      taskId: widget.taskId,
      amount: amount,
      image: _selectedImage!,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendInvoiceCubit, SendInvoiceState>(
      listener: (context, state) {
        if (state is SendInvoiceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invoice has been sent successfully"),
              backgroundColor: AppColors.lmcOrange,
            ),
          );
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            Routes.show_tasks,
          ); // العودة بعد الإرسال
        } else if (state is SendInvoiceFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: -110.h,
                left: -30.w,
                right: -30.w,
                child: TopContainer(height: 300.h, border: true),
              ),

              Positioned(
                top: 90.h,
                left: 50.w,
                right: 50.w,
                child: Center(
                  child: Text(
                    "Send Invoice",
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 250.h,
                left: 30.w,
                right: 30.w,
                child: Column(
                  children: [
                    GlassContainer(
                      width: double.infinity,
                      height: 100.h,
                      topLeft: 15,
                      topRight: 15,
                      bottomRight: 15,
                      bottomLeft: 15,
                      firstColor: AppColors.lmcBlue,
                      secondColor: AppColors.lightLmcBlue,
                      firstBlurOpacity: 0.25,
                      secondBlurOpacity: 0.15,
                      withBorder: false,

                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          widget.content,
                          style: TextStyle(
                            color: AppColors.lmcBlue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(20.h),
                    GeneralTextFormField(
                      hintText: "Amount",
                      hintTextStyle: TextStyle(color: AppColors.greyBorder),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.greyBorder,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lmcOrange,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      inputTextStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.lmcBlue,
                      ),
                      prefixIcon: Icon(
                        Icons.money_outlined,
                        color: AppColors.lmcBlue,
                        size: 25.sp,
                      ),
                      controller: _amountController,
                    ),
                    verticalSpace(20.h),
                    AppTextButton(
                      buttonText: "Take a photo",
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: AppColors.background2,
                      ),
                      onPressed: _pickImageFromCamera,
                      backgroundColor: AppColors.lmcBlue,
                    ),
                    verticalSpace(20.h),
                    _selectedImage != null
                        ? Image(image: FileImage(_selectedImage!), height: 200)
                        : Image(
                          image: AssetImage('assets/images/LMC-LOGO.png'),
                          height: 200,
                        ),
                    verticalSpace(20.h),
                    if (state is SendInvoiceLoading)
                      CircularProgressIndicator()
                    else
                      AppTextButton(
                        buttonText: "Send Invoice",
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.background2,
                        ),
                        onPressed: () => _submitInvoice(context),
                        backgroundColor: AppColors.lmcBlue,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

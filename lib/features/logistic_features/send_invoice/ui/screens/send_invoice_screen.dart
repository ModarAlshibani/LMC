import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/core/widgets/custom_app_bar.dart';
import 'package:lmc_app/features/logistic_features/send_invoice/logic/cubit/send_invoice_cubit.dart';

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

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Select Image Source',
            style: TextStyle(
              color: AppColors.lmcBlue,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.lmcBlue,
                ),
                title: Text(
                  'Camera',
                  style: TextStyle(
                    color: AppColors.lmcBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.lmcBlue,
                ),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                    color: AppColors.lmcBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitInvoice(BuildContext context) {
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an invoice image"),
          backgroundColor: Colors.red,
        ),
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
          Navigator.pushReplacementNamed(context, Routes.show_tasks);
        } else if (state is SendInvoiceFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background2,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: "Send Invoice"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task Content Section
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.lmcBlue.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.lmcBlue.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Task Details",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lmcBlue,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  widget.content,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lmcBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Amount Section
                          Text(
                            "Invoice Amount",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          GeneralTextFormField(
                            controller: _amountController,
                            hintText: "Enter invoice amount",

                            hintTextStyle: TextStyle(
                              color: AppColors.lmcBlue.withOpacity(0.7),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.lmcBlue.withOpacity(0.2),
                                width: 1.3,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.lmcOrange.withOpacity(0.8),
                                width: 1.3,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            inputTextStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lmcBlue,
                            ),
                            prefixIcon: Icon(
                              Icons.attach_money,
                              color: AppColors.lmcBlue.withOpacity(0.7),
                              size: 24.sp,
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Image Section
                          Text(
                            "Invoice Image",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Image Upload Container
                          GestureDetector(
                            onTap: _showImageSourceDialog,
                            child: Container(
                              width: double.infinity,
                              height: _selectedImage != null ? null : 200.h,
                              decoration: BoxDecoration(
                                color: AppColors.lmcBlue.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: AppColors.lmcBlue.withOpacity(0.2),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child:
                                  _selectedImage != null
                                      ? Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                            child: Image.file(
                                              _selectedImage!,
                                              width: double.infinity,
                                              height: 300.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 8.h,
                                            right: 8.w,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedImage = null;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(4.w),
                                                decoration: BoxDecoration(
                                                  color: Colors.red.withOpacity(
                                                    0.8,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.r,
                                                      ),
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            size: 48.sp,
                                            color: AppColors.lmcBlue
                                                .withOpacity(0.7),
                                          ),
                                          SizedBox(height: 12.h),
                                          Text(
                                            "Tap to select image",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.lmcBlue
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            "Camera or Gallery",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.lmcBlue
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Submit Button
                          if (state is SendInvoiceLoading)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                color: AppColors.lmcOrange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: AppColors.lmcOrange.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.lmcOrange,
                                ),
                              ),
                            )
                          else
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.lmcOrange,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.lmcOrange.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => _submitInvoice(context),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                child: Text(
                                  "Send Invoice",
                                  style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

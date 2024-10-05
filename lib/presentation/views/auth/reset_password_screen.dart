import 'package:JazakAllah/presentation/views/auth/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_weights.dart';
import '../../../data/utility/token_manager.dart';
import '../../../data/viewmodel/auth/reset_password_screen_controller.dart';
import '../../../constants/images.dart';
import '../../widgets/functions_and_methods.dart';
import '../../widgets/congrats_custom_dialogue_widget.dart';
import '../../widgets/loading_popup_widget.dart';
import '../../widgets/app_background_image_widget.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/form_field_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.email, required this.otp});

  final String email, otp;

  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          AppBackgroundImageWidget(bgImagePath: AssetsPath.background03SVG),
          // Custom Appbar
          CustomAppbarWidget(screenTitle: 'reset_password'.tr),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                SizedBox(
                  height: 116.h,
                ),
                _buildHeader(),
                SizedBox(height: 24.h),
                // Form section
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildInputField(),
                        SizedBox(height: 32.h),
                        _buildSubmitButton(context),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
                child: Column(
                  children: [
                    Text(
                      'rps_title'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.sp,
                        fontWeight: FontWeights.semiBold,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'rps_subtitle'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              );
  }

  Widget _buildInputField(){
    return Column(
      children: [
        FormFieldWidget(
          formTitle: 'auth_password'.tr,
          hintText: '****************',
          controller: passwordTEController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),
        SizedBox(height: 16.h),
        FormFieldWidget(
          formTitle: 'auth_confirm_password'.tr,
          hintText: '****************',
          controller: confirmPasswordTEController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return GetBuilder<ResetPasswordScreenController>(
                          builder: (resetPasswordScreenController) {
                        // Elevated button
                        return SizedBox(
                          height: 54.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Remove/hide keypad
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());
                              // Checking form validation method
                              checkFormErrors(
                                  resetPasswordScreenController, context);
                            },
                            child: Text(
                              'complete_btn_txt'.tr,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.sp,
                                  color: AppColors.colorBlackHighEmp,
                                  fontWeight: FontWeights.semiBold),
                            ),
                          ),
                        );
                      });
  }

  //Form error checking method
  void checkFormErrors(
      ResetPasswordScreenController controller, BuildContext context) {
    if (passwordTEController.text.isEmpty) {
      makeSnack('error_password_hint'.tr);
      return;
    }
    if (passwordTEController.text.length < 8) {
      makeSnack('error_password_hint2'.tr);
      return;
    }
    if (confirmPasswordTEController.text.isEmpty) {
      makeSnack(
          'error_confirm_password_hint'.tr);
      return;
    }
    if (confirmPasswordTEController.text != passwordTEController.text) {
      makeSnack('error_confirm_password_hint2'.tr);
      return;
    }
    // Loading indicator method
    showLoadingDialog(context);

    // Reset Password method
    resetPassword(controller, context);
  }

  //Password reset successful popup method
  void showCustomAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CongratulationsCustomAlertDialogWidget(
          title: 'congratulations_txt'.tr,
          message: 'successfully_password_reset_msg'.tr,
          onContinuePressed: () async {
            print('Password Reset successful');
            // Clear token value
            await AuthController.clearTokenValue();
            // Navigate to sign in screen
            Get.offAll(() => SignInScreen(isParent: true));
          },
        );
      },
    );
  }

  // Loading indicator
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingPopupWidget();
      },
    );
  }

  // Reset Password method
  Future<void> resetPassword(
      ResetPasswordScreenController controller, BuildContext context) async {
    final response =
        await controller.resetPassword(email, passwordTEController.text, otp);
    print(response);
    if (response) {
      Get.back();
      showCustomAlertDialog(context);
    } else {
      Get.back();
      makeSnack(controller.message);
    }
  }
}

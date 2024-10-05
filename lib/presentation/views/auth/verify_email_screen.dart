import 'package:JazakAllah/constants/colors.dart';
import 'package:JazakAllah/presentation/views/auth/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/fonts_weights.dart';
import '../../../data/viewmodel/auth/verify_email_screen_controller.dart';
import '../../../constants/images.dart';
import '../../widgets/functions_and_methods.dart';
import '../../widgets/loading_popup_widget.dart';
import '../../widgets/app_background_image_widget.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/form_field_widget.dart';

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key});

  final TextEditingController emailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          AppBackgroundImageWidget(bgImagePath: AssetsPath.background03SVG),
          // Custom Appbar
          CustomAppbarWidget(
            screenTitle: 'forgot_password2'.tr,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWidget(),
                  SizedBox(height: 32.h),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWidget() {
    return FormFieldWidget(
      formTitle: 'auth_email'.tr,
      hintText: 'example@domain.com',
      controller: emailTEController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return GetBuilder<VerifyEmailScreenController>(
        builder: (forgotPasswordScreenController) {
      // Elevated button
      return SizedBox(
        height: 54.h,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Keyboard hiding
            FocusScope.of(context).requestFocus(FocusNode());
            // Form error checking method
            checkFormErrors(forgotPasswordScreenController, context);
          },
          child: Text(
            'reset_password'.tr,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: AppColors.colorBlackHighEmp,
                fontWeight: FontWeights.semiBold),
          ),
        ),
      );
    });
  }

  //Form error checking method
  void checkFormErrors(
      VerifyEmailScreenController controller, BuildContext context) {
    if (emailTEController.text.isEmpty) {
      makeSnack('error_email_hint'.tr);
      return;
    }
    if (!GetUtils.isEmail(emailTEController.text)) {
      makeSnack('error_valid_email_hint'.tr);
      return;
    }
    // Loading indicator method
    showLoadingDialog(context);
    // Forgot password method
    verifyEmail(controller);
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

  // Signup method
  Future<void> verifyEmail(VerifyEmailScreenController controller) async {
    final response =
        await controller.verifyEmail(emailTEController.text.trim());
    print(response);
    if (response) {
      Get.back();
      print('Password reset successful');
      // Navigate to reset otp screen
      Get.to(() => VerifyOtpScreen(email: emailTEController.text.trim()));
    } else {
      Get.back();
      makeSnack(controller.message);
    }
  }
}

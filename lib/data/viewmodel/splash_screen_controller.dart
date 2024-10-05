import 'package:get/get.dart';
import '../../presentation/views/home/home_screen.dart';
import '../../presentation/views/onboarding_screen.dart';
import '../../presentation/views/menus/preferance/change_language_screen.dart';
import '../utility/token_manager.dart';
import 'navigation_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToNextScreen();
  }

  //Method for navigate next screen
  Future<void> goToNextScreen() async {
    await AuthController.getAccessToken();
    await AuthController.getExpireDateAndTime();
    await NavigationController.getOnboardingValue();
    await NavigationController.getLanguageValue();
    await Future.delayed(const Duration(seconds: 2));
    if (NavigationController.isLanguageSelectionComplete ?? true) {
      Get.offAll(() => const ChangeLanguageScreen(backButton: false,));
    } else {
      if (NavigationController.isOnboardingComplete ?? true) {
        Get.offAll(() => OnboardingScreen());
      } else {
        if(AuthController.isLoggedIn){
          Get.offAll(() => const HomeScreen(loadUserData: true,));
        } else{
          Get.offAll(() => const HomeScreen(loadUserData: false,));
        }
      }
    }
  }
}

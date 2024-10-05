import 'package:JazakAllah/initial_binder.dart';
import 'package:JazakAllah/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants/localization/app_constants.dart';
import 'constants/localization/messages.dart';
import 'constants/theme_manager.dart';
import 'data/viewmodel/language_controller.dart';

class JazakAllah extends StatelessWidget {
  const JazakAllah({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    /// Lock the orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<LocalizationController>(
          builder: (localizationController) {
            return GetMaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'USA'),
                Locale('ar', 'SA'),
              ],
              debugShowCheckedModeBanner: false,
              title: 'JazakAllah',
              theme: ThemeManager.getAppTheme(),
              locale: localizationController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(
                AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode,
              ),
              initialBinding: InitialBinder(),
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}

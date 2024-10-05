import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/localization/app_constants.dart';
import '../../data/models/language_model.dart';

class LocalizationController extends GetxController {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode,
      AppConstants.languages[0].countryCode);

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;

  List<LanguageModel> get languages => _languages;

  void loadCurrentLanguage() {
    _locale = Locale(
        sharedPreferences.getString(AppConstants.languageCode) ??
            AppConstants.languages[0].languageCode,
        sharedPreferences.getString(AppConstants.countryCode) ??
            AppConstants.languages[0].countryCode);

    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
    print('Load language');
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    print(_locale);
    update();
    print(_locale);
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
        AppConstants.languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstants.countryCode, locale.countryCode!);
  }
}

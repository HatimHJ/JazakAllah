import 'package:JazakAllah/presentation/views/menus/prayer_time_screen.dart';
import 'package:JazakAllah/presentation/views/menus/preferance/preference_screen.dart';
import 'package:JazakAllah/presentation/views/menus/subscription_and_donation_screen.dart';
import 'package:JazakAllah/presentation/views/menus/zakat_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';
import '../../../constants/fonts_weights.dart';
import '../../../constants/images.dart';
import '../../../constants/colors.dart';
import '../../../data/viewmodel/Providers/user_provider.dart';
import '../../../data/utility/token_manager.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/sub_category_list_widget.dart';
import '../Qibla/qibla_compass_screen.dart';
import '../auth/signin_screen.dart';
import 'chat_screen.dart';
import 'edit_profile_screen.dart';
import 'islamic_baby_name_screen.dart';
import 'islamic_calender.dart';
import 'makka_live_screen.dart';
import 'mosque_loaction_screen.dart';

void showBottomSheetMethod(BuildContext context) {
  final provider = Provider.of<UserProvider>(context, listen: false);

  List _menuItems = [
    {
      'icon': AssetsPath.alQuranIconPNG,
      'label': 'alquran'.tr,
      'onTap': () {
        getCategories('dua-categories', 'AL-QURAN');
      },
    },
    {
      'icon': AssetsPath.hadithIconPNG,
      'label': 'hadith'.tr,
      'onTap': () {
        getCategories('hadith-categories', 'HADITH');
      },
    },
    {
      'icon': AssetsPath.donationIconPNG,
      'label': 'donation2'.tr,
      'onTap': () async {
        provider.userData!.thumbnailUrl == 'Null'
            ? showCustomAlertDialog(context)
            : Get.to(() => const SubscriptionAndDonationScreen());
      },
    },
    {
      'icon': AssetsPath.islamicAiIconPNG,
      'label': 'islamic_ai'.tr,
      'onTap': () {
        Get.back();
        Get.to(() => const ChatScreen());
      },
    },
    {
      'icon': AssetsPath.adhanIconPNG,
      'label': 'prayer_time'.tr,
      'onTap': () {
        Get.back();
        Get.to(() => const PrayerTimeScreen());
      },
    },
    {
      'icon': AssetsPath.qiblaCompusIconPNG,
      'label': 'qibla_compass'.tr,
      'onTap': () {
        Get.back();
        Get.to(() => const CompassScreen());
      },
    },
    {
      'icon': AssetsPath.zakatIconPNG,
      'label': 'jakat_calculator'.tr,
      'onTap': () {
        Get.back();
        Get.to(() => const ZakatCalculator());
      },
    },
    {
      'icon': AssetsPath.babyNameIconPNG,
      'label': 'baby_name'.tr,
      'onTap': () {
        Get.back();
        Get.to(() => const IslamicBabyNameScreen());
      },
    },
    {
      'icon': AssetsPath.makkaIconPNG,
      'label': 'makka_live'.tr,
      'onTap': () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MakkahLiveScreen()));
      },
    },
    {
      'icon': AssetsPath.azkarIconPNG,
      'label': 'azkar'.tr,
      'onTap': () {
        getCategories('azkar-categories', 'AZKAR');
      },
    },
    {
      'icon': AssetsPath.calenderIconPNG,
      'label': 'islamic_calender'.tr,
      'onTap': () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HijriDatePickerDialog(
              initialDate: HijriCalendar.now(),
              firstDate: HijriCalendar.addMonth(1356, 1),
              lastDate: HijriCalendar.addMonth(1499, 1),
              initialDatePickerMode: DatePickerMode.day,
            ),
          ),
        );
      },
    },
    {
      'icon': AssetsPath.mosqueIconPNG,
      'label': 'mosque_location'.tr,
      'onTap': () {
        Get.back();
        Get.to(() => const MosqueLocationScreen());
      },
    },
    {
      'icon': AssetsPath.preferencesIconPNG,
      'label': 'preference'.tr,
      'onTap': () {
        Get.back();
        Get.to(() => const PreferenceScreen());
      },
    },
    {
      'icon': AssetsPath.accountIconPNG,
      'label': 'edit_profile'.tr,
      'onTap': () async {
        Get.back();
        provider.userData!.thumbnailUrl == 'Null'
            ? showCustomAlertDialog(context)
            : Get.to(() => const EditProfileScreen());
      },
    },
    {
      'icon': AssetsPath.loginIconPNG,
      'label': 'sign_in'.tr,
      'onTap': () async {
        Get.offAll(SignInScreen(isParent: true));
      },
    },
  ];

  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    constraints: BoxConstraints.expand(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 150),
    builder: (BuildContext context) {
      return IntrinsicHeight(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.colorGradient1Start,
                AppColors.colorGradient1End
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                _buildContentsArea(),
                SizedBox(height: 10.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _menuItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        final item = _menuItems[index];

                        if (index == _menuItems.length - 1) {
                          return provider.userDataLoading ||
                                  provider.userData!.thumbnailUrl == 'Null'
                              ? _buildSignin()
                              : _buildLogout();
                        } else {
                          return _buildCardDesign(item);
                        }
                      },
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

Widget _buildContentsArea() {
  return Container(
    height: 6.h,
    width: 57.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50), color: AppColors.colorWhite38),
  );
}

Widget _buildSignin() {
  return InkWell(
    onTap: () async {
      Get.offAll(SignInScreen(isParent: true));
    },
    child: Container(
      height: 110.0,
      width: 102.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.colorWhiteHighEmp,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.login,
            size: 28.0,
            color: AppColors.colorPrimary,
          ),
          const SizedBox(height: 8.0),
          Text(
            'sign_in'.tr,
            style: const TextStyle(
              color: AppColors.colorBlackHighEmp,
              fontSize: 13.0,
              fontWeight: FontWeights.semiBold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildLogout() {
  return InkWell(
    onTap: () async {
      // Clear token value
      await AuthController.clearTokenValue();
      // Navigate to sign in screen
      Get.offAll(() => SignInScreen(isParent: true));
    },
    child: Container(
      height: 110.h,
      width: 102.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.colorWhiteHighEmp,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsPath.logoutIconPNG,
            height: 32.h,
            width: 32.w,
          ),
          const SizedBox(height: 8.0),
          Text(
            'logout'.tr,
            style: const TextStyle(
              color: AppColors.colorBlackHighEmp,
              fontSize: 13.0,
              fontWeight: FontWeights.semiBold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCardDesign(item) {
  return GestureDetector(
    onTap: item['onTap'],
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.colorWhiteHighEmp,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: -2.0,
            blurRadius: 4.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item['icon'].toString(),
            height: 32.h,
            width: 32.w,
          ),
           SizedBox(height: 8.h),
          Text(
            item['label'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.colorBlackHighEmp,
              fontSize: 14.sp,
              fontWeight: FontWeights.semiBold,
            ),
          ),
        ],
      ),
    ),
  );
}

getCategories(String categoryName, String cateSign) {
  if (cateSign == 'HADITH') {
    Get.back();
    Get.to(
      () => SubCategoryListWidget(
        categoryTitle: 'hadith',
        iconPath: AssetsPath.hadithIconSVG,
        categoryName: categoryName,
        cateSign: cateSign,
      ),
    );
  } else {
    if (cateSign == 'DUA') {
      Get.back();
      Get.to(
        () => SubCategoryListWidget(
          categoryTitle: 'dua',
          iconPath: AssetsPath.duaIconSVG,
          categoryName: categoryName,
          cateSign: cateSign,
        ),
      );
    } else {
      if (cateSign == 'AL-QURAN') {
        Get.back();
        Get.to(
          () => SubCategoryListWidget(
            categoryTitle: 'alquran',
            iconPath: AssetsPath.quranIconSVG,
            categoryName: categoryName,
            cateSign: cateSign,
          ),
        );
      } else {
        if (cateSign == 'AZKAR') {
          Get.back();
          Get.to(
            () => SubCategoryListWidget(
              categoryTitle: 'azkar',
              iconPath: AssetsPath.duaIconSVG,
              categoryName: categoryName,
              cateSign: cateSign,
            ),
          );
        } else {
          if (cateSign == 'EVENT-PRAYERS') {
            Get.back();
            Get.to(
              () => SubCategoryListWidget(
                categoryTitle: 'event_prayers',
                iconPath: AssetsPath.duaIconSVG,
                categoryName: categoryName,
                cateSign: cateSign,
              ),
            );
          }
        }
      }
    }
  }
}

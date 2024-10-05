import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_weights.dart';
import '../../../constants/images.dart';
import '../../../data/viewmodel/Providers/location_provider.dart';
import '../../widgets/app_background_image_widget.dart';
import '../../widgets/custom_appbar_widget.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({Key? key}) : super(key: key);

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  bool hasPermission = false;

  Future<void> getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      final status = await Permission.location.request();
      setState(() {
        hasPermission = (status == PermissionStatus.granted);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  String _formatPrayerTime(DateTime time) {
    return DateFormat.jm().format(time);
  }

  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          AppBackgroundImageWidget(bgImagePath: AssetsPath.secondaryBGSVG),
          Column(
            children: [
              CustomAppbarWidget(screenTitle: 'prayer_times'.tr),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        _buildPrayerTime(provider),
                        SizedBox(height: 20.h),
                        _buildPrayerNotifications()
                     ]
                    ),
                  ),
              ),
            ],
          ),
          provider.initPosition == null
              ? _buildIfLocationOf(context)
              : const SizedBox()
        ],
      ),
    );
  }


  Widget _buildPrayerTime(LocationProvider provider) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 420.h,
        width: 328.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [
              AppColors.colorGradient1Start,
              AppColors.colorGradient1End
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDate(),
            _buildPrayerTimeRow('fajr'.tr, provider.prayerTimes![0].fajr,
                AssetsPath.fazr, provider),
            _buildPrayerTimeRow('duhr'.tr, provider.prayerTimes![0].dhuhr,
                AssetsPath.duhr, provider),
            _buildPrayerTimeRow('asr'.tr, provider.prayerTimes![0].asr,
                AssetsPath.asr, provider),
            _buildPrayerTimeRow('magrib'.tr, provider.prayerTimes![0].maghrib,
                AssetsPath.magrib, provider),
            _buildPrayerTimeRow('isha'.tr, provider.prayerTimes![0].isha,
                AssetsPath.isha, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 20.h, right: 20.h),
      child: Text(
        DateFormat('EEEE, d MMMM, yyyy').format(DateTime.now()),
        style: TextStyle(
          color: AppColors.colorWhiteHighEmp,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPrayerTimeRow(String prayerName, DateTime prayerTime,
      String iconPath, LocationProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0, left: 16.0, right: 16),
      child: Container(
        height: 50.h,
        width: 296.w,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.colorWhiteHighEmp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60.w,
              child: Text(
                prayerName.tr,
                style: TextStyle(
                  color: AppColors.colorWhiteHighEmp,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              provider.formatPrayerTime(
                  prayerTime.subtract(const Duration(minutes: 3))),
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset(
              iconPath,
              height: 18.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerNotifications() {
    return Column(
      children: [
        Consumer<LocationProvider>(
          builder: (context, provider, child) {
            return Container(
              width: 328.w,
              margin: EdgeInsets.only(bottom: 40.h),
              padding:  EdgeInsets.only(top: 20.h, left: 20.h, right: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.colorGradient1Start,
                    AppColors.colorGradient1End
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'notification'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.colorWhiteHighEmp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildNotificationRow(
                    provider,
                    'fajr',
                    provider.fajrNotification!,
                    (value) => provider.settingNotification('fajr'),
                  ),
                  _buildNotificationRow(
                    provider,
                    'duhr',
                    provider.dhuharNotification!,
                    (value) => provider.settingNotification('dhuhr'),
                  ),
                  _buildNotificationRow(
                    provider,
                    'asr',
                    provider.asrNotification!,
                    (value) => provider.settingNotification('asr'),
                  ),
                  _buildNotificationRow(
                    provider,
                    'magrib',
                    provider.maghribNotification!,
                    (value) => provider.settingNotification('maghrib'),
                  ),
                  _buildNotificationRow(
                    provider,
                    'isha',
                    provider.ishaNotification!,
                    (value) => provider.settingNotification('isha'),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildNotificationRow(LocationProvider provider, String prayerName,
      bool notificationValue, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          prayerName.tr,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.colorWhiteHighEmp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Switch(
          activeColor: AppColors.colorWhiteHighEmp,
          activeTrackColor: AppColors.colorPrimary,
          value: notificationValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildIfLocationOf(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
          AssetImage(AssetsPath.background2nd),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Container(
          height: 300.h,
          width: 300.w,
          decoration: BoxDecoration(
              color: AppColors.colorWhiteHighEmp,
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 50.h,
                color: AppColors.colorError,
              ),
              SizedBox(height: 10.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // Align children along the main axis (vertically)
                crossAxisAlignment: CrossAxisAlignment.center,
                // Align children along the cross axis (horizontally)
                children: [
                  Text(
                    'unable'.tr,
                    style: const TextStyle(
                        color: AppColors.colorBlack),
                  ),
                  Text(
                    'turn_on'.tr,
                    style: const TextStyle(
                        color: AppColors.colorBlack),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'access'.tr,
                      style: const TextStyle(
                          color: AppColors.colorBlack),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(
                        Icons.arrow_back,
                        size: 14.h,
                        color: AppColors.colorError,
                      ),
                      Text(
                        'go_back'.tr,
                        style: const TextStyle(
                            color: AppColors.colorError),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

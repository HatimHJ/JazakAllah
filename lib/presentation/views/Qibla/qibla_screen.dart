import 'dart:math';
import 'package:JazakAllah/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_weights.dart';
import '../../../data/viewmodel/Providers/location_provider.dart';
import '../../widgets/app_background_image_widget.dart';
import '../../widgets/custom_appbar_widget.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({Key? key}) : super(key: key);

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahScreenState extends State<QiblahScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the AnimationController
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Stack(
          children: [
            AppBackgroundImageWidget(bgImagePath: AssetsPath.secondaryBGSVG),
            CustomAppbarWidget(
              screenTitle: "qibla_compass2".tr,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 120.h),
                StreamBuilder(
                  stream: FlutterQiblah.qiblahStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        alignment: Alignment.center,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.colorWhiteHighEmp,
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // Check if snapshot has data
                      final qiblahDirection = snapshot.data;
                      animation = Tween(
                        begin: begin,
                        end: (qiblahDirection!.qiblah * (pi / 180) * -1),
                      ).animate(_animationController!);

                      begin = (qiblahDirection.qiblah * (pi / 180) * -1);

                      if (!_animationController!.isAnimating) {
                        _animationController?.forward(from: 0);
                      }

                      return Center(child: Consumer<LocationProvider>(
                          builder: (context, provider, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Location
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
                              child: Container(
                                height: 40.h,
                                width: 200.w,
                                constraints: BoxConstraints(maxWidth: 350.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.colorPrimaryDarker),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2.0, right: 5.0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: AppColors.indicatorColor,
                                        size: 16.sp,
                                      ),
                                    ),
                                    provider.locationName == ''
                                        ? SizedBox(
                                            width: 150.w,
                                            child: Center(
                                              child: Text(
                                                'loading.....',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .colorPrimaryLighter,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            width: 150.w,
                                            child: Text(
                                              provider.locationName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.indicatorColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 80.h),
                            ///Compass
                            SizedBox(
                              height: 280.h,
                              child: AnimatedBuilder(
                                animation: animation!,
                                builder: (context, child) => Transform.rotate(
                                  angle: animation!.value,
                                  child: Image.asset(AssetsPath.compass2),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ///text
                            Text(
                              ("rotate".tr),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.colorWhiteHighEmp,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 16.h),

                            Text(
                              "${qiblahDirection.direction.toInt()}°",
                              style: TextStyle(
                                color: AppColors.colorButtonGradientEnd,
                                fontSize: 24.sp,
                                fontWeight: FontWeights.semiBold,
                              ),
                            ),
                          ],
                        );
                      },),);
                    } else {
                      // Handle no data scenario
                      return Center(
                        child: Text(
                          'unble_to_get_qible'.tr,
                          style: const TextStyle(
                              color: AppColors.colorWhiteHighEmp),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 25,
              right: 25,
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: 'if_qibla_compass_not_working_properly'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
                child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.withOpacity(.4))),
                    height: 24,
                    width: 24,
                    child: Image.asset(
                      AssetsPath.qiblaInfo,
                      color: Colors.grey.withOpacity(.4),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

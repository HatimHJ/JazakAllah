import 'dart:convert';
import 'package:JazakAllah/presentation/views/home/tasbih_counter_screen.dart';
import 'package:JazakAllah/presentation/views/menus/subscription_and_donation_screen.dart';
import 'package:JazakAllah/presentation/views/home/today_dua_screen.dart';
import 'package:JazakAllah/presentation/views/home/today_hadith_screen.dart';
import 'package:JazakAllah/presentation/views/wallpapers/all_wallpers_screen.dart';
import 'package:JazakAllah/presentation/widgets/functions_and_methods.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts_weights.dart';
import '../../../data/viewmodel/Providers/hadith_provider.dart';
import '../../../data/viewmodel/Providers/link_provider.dart';
import '../../../data/viewmodel/Providers/location_provider.dart';
import '../../../data/viewmodel/Providers/user_provider.dart';
import '../../../constants/images.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/loading_popup_widget.dart';
import '../Qibla/qibla_compass_screen.dart';
import '../menus/chat_screen.dart';
import '../menus/islamic_baby_name_screen.dart';
import '../menus/menu_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  final bool loadUserData;

  const HomeScreen({super.key, required this.loadUserData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    readJson();
    loadData();
  }

  Future<void> loadData() async {
    Provider.of<UserProvider>(context, listen: false)
        .fetchLoggedInUserData(widget.loadUserData);
    Provider.of<HadithProvider>(context, listen: false).getLanguage();
    Provider.of<LocationProvider>(context, listen: false).getLocation();
    Provider.of<LinkProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Stack(
        children: [
          Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.colorGradient1Start,
                    AppColors.colorGradientX
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  appBar(),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: 16.h),
                      children: [
                        Column(
                          children: [
                            homeMenuWidget(),
                            SizedBox(height: 20.h),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.colorGradient1Start,
                                            AppColors.colorGradientX
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: AppColors.colorWhiteHighEmp,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 120.h),
                                            homePrayerTimeWidget(),
                                            SizedBox(height: 20.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "today_hadith".tr,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            _buildTodayHadithCard(),
                                            SizedBox(height: 8.h),
                                            _buildTodayDuaCard(),
                                            SizedBox(height: 20.h),
                                            _buildNameBanner(),
                                            SizedBox(height: 20.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    slider(),
                                    SizedBox(height: 4.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: _buildPageIndicator(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _buildBottomNavigation(context),
          ),
          userProvider.userDataLoading
              ? Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  body: const LoadingPopupWidget(),
                )
              : const SizedBox(),
        ],
      );
    });
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 70.h,
      width: double.infinity,
      color: AppColors.colorWhiteHighEmp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SvgPicture.asset(
              AssetsPath.homeIconSVG,
              height: 50.h,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(() => const CompassScreen());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsPath.compassIconSVG,
                    height: 20.h,
                  ),
                  Text(
                    'qibla_compass2'.tr,
                    style: TextStyle(fontSize: 10.sp),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(() => const ChatScreen());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsPath.chatIconSVG,
                    height: 20.h,
                  ),
                  Text(
                    "chat".tr,
                    style: TextStyle(fontSize: 10.sp),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showBottomSheetMethod(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsPath.menuIconSVG,
                    height: 20.h,
                  ),
                  Text(
                    'menu'.tr,
                    style: TextStyle(fontSize: 10.sp),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Fetch Zikir from json
  List _zikir = [];

  Future<void> readJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    print(language);
    String jsonAssetPath = 'assets/locales/zikir_ar.json';
    if (language == 'en') {
      jsonAssetPath = 'assets/locales/zikir_en.json';
    } else if (language == 'ar') {
      jsonAssetPath = 'assets/locales/zikir_ar.json';
    }

    final String response = await rootBundle.loadString(jsonAssetPath);
    final data = await json.decode(response);
    setState(() {
      _zikir = data['data'];
    });
  }

  //Home screen appBar widget
  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  userProvider.userDataLoading
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            AssetsPath.avater,
                            height: 46.h,
                          ),
                        )
                      : userProvider.userData!.thumbnailUrl == 'Null' ||
                              userProvider.userData!.thumbnailUrl!.isEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                AssetsPath.avater,
                                height: 46.h,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Container(
                                height: 46.h,
                                width: 46.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.colorWhiteHighEmp),
                                child: Image.network(
                                  userProvider.userData!.thumbnailUrl!,
                                  fit: BoxFit.cover,
                                  height: 46.h,
                                  width: 46.h,
                                ),
                              ),
                            ),
                  SizedBox(width: 12.w),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'assalamu_alaikum'.tr,
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeights.semiBold,
                              color: AppColors.colorWarning,
                              height: 0.9),
                        ),
                        Text(
                          userProvider.userDataLoading
                              ? "........"
                              : userProvider.userData!.fullName!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeights.light,
                            color: AppColors.colorWhiteHighEmp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // InkWell(
              //     onTap: (){
              //       makeSnack("Coming soon: This section is currently under development");
              //     },
              //     child: SvgPicture.asset(AssetsPath.notification, height: 24, width: 24,)),
            ],
          );
        },
      ),
    );
  }

  ///CarouselSlider Widget
  Widget slider() {
    return CarouselSlider(
      items: [
        buildCarouselItem(
          image: AssetsPath.bannerOne,
          header: 'b_one_header'.tr,
          title: 'b_one_title'.tr,
          buttonText: 'b_one_btn'.tr,
          onTap: () {
            Get.to(() => const TasbihCounterScreen(data: ''));
          },
        ),
        buildCarouselItem(
          image: AssetsPath.bannerTwo,
          header: 'b_two_header'.tr,
          title: 'b_two_title'.tr,
          buttonText: 'b_two_btn'.tr,
          onTap: () {
            getCategories('dua-categories', 'AL-QURAN');
          },
        ),
        buildCarouselItem(
          image: AssetsPath.bannerThree,
          header: 'b_three_header'.tr,
          title: 'b_three_title'.tr,
          buttonText: 'b_three_btn'.tr,
          onTap: () {
            Get.to(() => const AllWallPapersScreen());
          },
        ),
      ],
      options: CarouselOptions(
        height: 150.h,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.95,
        onPageChanged: (index, reason) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }

  Widget buildCarouselItem({
    required String image,
    required String header,
    required String title,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 50.h,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.colorWhiteHighEmp,
                height: 3.h,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.caprasimo(
                textStyle: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorWhiteHighEmp,
                  height: 0.9.h,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.colorPrimary,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.colorWhiteHighEmp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 7.h,
      width: isActive ? 18.w : 8.w,
      decoration: BoxDecoration(
        color: isActive ? AppColors.colorGradient5End : AppColors.colorGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget homeMenuWidget() {
    final provider = Provider.of<UserProvider>(context, listen: false);
    List menuItems = [
      {
        'icon': AssetsPath.tasbihCounterIconPNG,
        'label': 'tasbih'.tr,
        'onTap': () {
          Get.to(() => const TasbihCounterScreen(
                data: '',
              ));
        }
      },
      {
        'icon': AssetsPath.hadithIconPNG,
        'label': 'hadith'.tr,
        'onTap': () {
          getCategories('hadith-categories', 'HADITH');
        }
      },
      {
        'icon': AssetsPath.duaIconPNG,
        'label': 'dua'.tr,
        'onTap': () {
          getCategories('dua-categories', 'DUA');
        }
      },
      {
        'icon': AssetsPath.alQuranIconPNG,
        'label': 'alquran'.tr,
        'onTap': () {
          getCategories('dua-categories', 'AL-QURAN');
        }
      },
      {
        'icon': AssetsPath.wallpaperIconPNG,
        'label': 'wallpaper'.tr,
        'onTap': () {
          Get.to(() => const AllWallPapersScreen());
        }
      },
      {
        'icon': AssetsPath.donationIconPNG,
        'label': 'donation2'.tr,
        'onTap': () async {
          provider.userData!.thumbnailUrl == 'Null'
              ? showCustomAlertDialog(context)
              : Get.to(() => const SubscriptionAndDonationScreen());
        }
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: false,
        itemCount: menuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: item['onTap'],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.colorWhiteHighEmp,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    spreadRadius: -2.0,
                    blurRadius: 4,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['icon'],
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
        },
      ),
    );
  }

  ///Home screen prayer time widget
  Widget homePrayerTimeWidget() {
    return Consumer<LocationProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          Container(
            height: 370.h,
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
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowColor,
                  spreadRadius: -2.0,
                  blurRadius: 4,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 290.h,
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
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowColor,
                              spreadRadius: -2.0,
                              blurRadius: 4,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 70.h,
                                  width: 50.w,
                                  child: Image.asset(
                                    AssetsPath.lamp01,
                                  ),
                                ),

                                ///locations
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, left: 8.0, right: 8.0),
                                  child: Container(
                                    height: 40.h,
                                    width: 200.w,
                                    constraints:
                                        BoxConstraints(maxWidth: 350.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.colorGreenDark),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .colorPrimaryLighter,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: 150.w,
                                                child: Text(
                                                  provider.locationName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .indicatorColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.sp),
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.h,
                                  width: 40.w,
                                  child: Image.asset(
                                    AssetsPath.lamp02,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'prayer_time'.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeights.regular,
                                  color: AppColors.colorWhiteHighEmp,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat(
                                      'd\'${provider.getDaySuffix(DateTime.now().day)}\' MMMM y')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.colorAlert),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 120.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorWhiteHighEmp),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent),
                                    child: Column(
                                      children: [
                                        if (provider.prayerTimes!.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.h,
                                                left: 12.h,
                                                right: 12.h,
                                                bottom: 0.h),
                                            child: Text(
                                              provider.formatPrayerTime(provider
                                                  .prayerTimes![0].fajr),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .colorWhiteHighEmp,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        SizedBox(height: 4.h),
                                        SvgPicture.asset(
                                          AssetsPath.fazr,
                                          height: 18.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'fajr'.tr,
                                            style: TextStyle(
                                                color:
                                                    AppColors.colorWhiteHighEmp,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    FontWeights.semiBold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 120.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorWhiteHighEmp),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent),
                                    child: Column(
                                      children: [
                                        if (provider.prayerTimes!.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.h,
                                                left: 12.h,
                                                right: 12.h,
                                                bottom: 0.h),
                                            child: Text(
                                              provider.formatPrayerTime(provider
                                                  .prayerTimes![0].dhuhr),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .colorWhiteHighEmp,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        SizedBox(height: 4.h),
                                        SvgPicture.asset(
                                          AssetsPath.duhr,
                                          height: 18.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'duhr'.tr,
                                            style: TextStyle(
                                                color:
                                                    AppColors.colorWhiteHighEmp,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    FontWeights.semiBold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 120.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorWhiteHighEmp),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent),
                                    child: Column(
                                      children: [
                                        if (provider.prayerTimes!.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.h,
                                                left: 12.h,
                                                right: 12.h,
                                                bottom: 0.h),
                                            child: Text(
                                              provider.formatPrayerTime(
                                                  provider.prayerTimes![0].asr),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .colorWhiteHighEmp,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        SizedBox(height: 4.h),
                                        SvgPicture.asset(
                                          AssetsPath.asr,
                                          height: 18.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'asr'.tr,
                                            style: TextStyle(
                                                color:
                                                    AppColors.colorWhiteHighEmp,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    FontWeights.semiBold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 120.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorWhiteHighEmp),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent),
                                    child: Column(
                                      children: [
                                        if (provider.prayerTimes!.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.h,
                                                left: 12.h,
                                                right: 12.h,
                                                bottom: 0.h),
                                            child: Text(
                                              provider.formatPrayerTime(provider
                                                  .prayerTimes![0].maghrib),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .colorWhiteHighEmp,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        SizedBox(height: 4.h),
                                        SvgPicture.asset(
                                          AssetsPath.magrib,
                                          height: 18.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'magrib'.tr,
                                            style: TextStyle(
                                                color:
                                                    AppColors.colorWhiteHighEmp,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    FontWeights.semiBold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 120.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorWhiteHighEmp),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent),
                                    child: Column(
                                      children: [
                                        if (provider.prayerTimes!.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.h,
                                                left: 12.h,
                                                right: 12.h,
                                                bottom: 0.h),
                                            child: Text(
                                              provider.formatPrayerTime(provider
                                                  .prayerTimes![0].isha),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .colorWhiteHighEmp,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        SizedBox(height: 4.h),
                                        SvgPicture.asset(
                                          AssetsPath.isha,
                                          height: 18.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'isha'.tr,
                                            style: TextStyle(
                                                color:
                                                    AppColors.colorWhiteHighEmp,
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    FontWeights.semiBold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsPath.asr,
                      height: 28.h,
                    ),
                    if (provider.prayerTimes!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'sun_set'.tr,
                              style:
                                  const TextStyle(color: AppColors.colorAlert),
                            ),
                            Text(
                              provider.formatPrayerTime(
                                  provider.prayerTimes![0].maghrib),
                              style: TextStyle(
                                  color: AppColors.colorWhiteHighEmp,
                                  fontSize: 20.sp),
                            )
                          ],
                        ),
                      ),
                    SizedBox(width: 30.h),
                    SvgPicture.asset(
                      AssetsPath.fazr,
                      height: 28.h,
                    ),
                    if (provider.prayerTimes!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'sun_rise'.tr,
                              style:
                                  const TextStyle(color: AppColors.colorAlert),
                            ),
                            Text(
                              provider.formatPrayerTime(provider
                                  .prayerTimes![0].fajr
                                  .subtract(const Duration(minutes: 3))),
                              style: TextStyle(
                                  color: AppColors.colorWhiteHighEmp,
                                  fontSize: 20.sp),
                            )
                          ],
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          provider.initPosition == null
              ? Center(
                  child: Container(
                    margin: EdgeInsets.all(16.w),
                    height: 330.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'unable'.tr,
                            style: const TextStyle(
                                color: AppColors.colorWhiteHighEmp),
                          ),
                          Text(
                            'turn_on_device_location'.tr,
                            style: const TextStyle(
                              color: AppColors.colorWhiteHighEmp,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .getLocation();
                              },
                              child: Container(
                                height: 100.h,
                                width: 100.w,
                                padding: const EdgeInsets.only(top: 30),
                                child: const Icon(
                                  Icons.refresh,
                                  color: AppColors.colorWhiteHighEmp,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );
    });
  }

  ///Random Hadith Widget
  Widget _buildTodayHadithCard() {
    return Consumer<HadithProvider>(
      builder: (context, hadithProvider, child) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TodayHadithScreen()));
          },
          child: Container(
            height: 210.h,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: AssetImage(AssetsPath.hadithBackgroundPNG),
                fit: BoxFit.fill,
              ),
            ),
            child: hadithProvider.randomHadithIndex == -1
                ? const Center(child: Text(""))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hadithProvider
                            .allHadith![hadithProvider.randomHadithIndex]
                            .hadithArabic!,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.colorWhiteHighEmp),
                      ),
                      SizedBox(height: 10.h),
                      hadithProvider.language == 'ar'
                          ? const SizedBox()
                          : Text(
                        hadithProvider.language == 'en' ? hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithEnglish!
                            : hadithProvider.language == 'ur' ? hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithUrdu!
                            : hadithProvider.language == 'tr' ? hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithTurkish!
                            : hadithProvider.language == 'bn' ? hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithBangla!
                            : hadithProvider.language == 'fr' ? hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithFrench!
                            : hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithHindi!,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.colorWhiteHighEmp),
                            )
                    ],
                  ),
          ),
        );
      },
    );
  }

  ///Random Dua Widget
  Widget _buildTodayDuaCard() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TodayDuaScreen()));
      },
      child: Consumer<HadithProvider>(builder: (context, duaProvider, child) {
        return Container(
          height: 240.h,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              image: AssetImage(AssetsPath.duaBackgroundPNG),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                "today_dua".tr,
                style: TextStyle(
                    color: AppColors.colorWhiteHighEmp, fontSize: 16.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              duaProvider.randomDuaIndex == -1
                  ? const Center(child: Text(""))
                  : Text(
                      duaProvider.language == 'ar'
                          ? duaProvider.allDua![duaProvider.randomDuaIndex].duaArabic!
                          : duaProvider.language == 'en' ? duaProvider.allDua![duaProvider.randomDuaIndex].duaEnglish!
                              : duaProvider.language == 'ur' ? duaProvider.allDua![duaProvider.randomDuaIndex].duaUrdu!
                                  : duaProvider.language == 'tr' ? duaProvider.allDua![duaProvider.randomDuaIndex].duaTurkish!
                                  : duaProvider.language == 'bn' ? duaProvider.allDua![duaProvider.randomDuaIndex].duaBangla!
                                  : duaProvider.language == 'fr' ? duaProvider.allDua![duaProvider.randomDuaIndex].duaFrench!
                                  : duaProvider.allDua![duaProvider.randomDuaIndex].duaHindi!,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 14.sp,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.colorWhiteHighEmp),
                    ),
            ],
          ),
        );
      }),
    );
  }

  ///Name generating banner widget
  Widget _buildNameBanner() {
    return Container(
      height: 160.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(AssetsPath.nameBanner),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'name_header'.tr,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorWhiteHighEmp,
                  height: 3.h),
            ),
            Text(
              'name_title'.tr,
              style: GoogleFonts.caprasimo(
                textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorWhiteHighEmp,
                    height: 0.9.h),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const IslamicBabyNameScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.colorAlert),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'name_btn'.tr,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.colorWhiteHighEmp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

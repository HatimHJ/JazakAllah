import 'dart:async';
import 'package:JazakAllah/presentation/views/home/tasbih_count_summery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../constants/fonts_weights.dart';
import '../../../constants/images.dart';
import '../../../constants/colors.dart';
import '../../../data/viewmodel/Providers/counter_provider.dart';
import '../../../data/viewmodel/Providers/db_helper/helper_function.dart';
import '../../../data/viewmodel/Providers/models/note_model.dart';
import '../../../data/viewmodel/Providers/models/zikir_model.dart';
import '../../../data/viewmodel/Providers/note_provider.dart';
import '../../widgets/app_background_image_widget.dart';
import '../../widgets/custom_appbar_widget.dart';

class TasbihCounterScreen extends StatefulWidget {
  final String data;

  const TasbihCounterScreen({super.key, required this.data});

  @override
  State<TasbihCounterScreen> createState() => _TasbihCounterScreenState();
}

class _TasbihCounterScreenState extends State<TasbihCounterScreen> {
  int countNumber = 0;
  int secondaryCountNumber = 0;
  late Stopwatch _stopwatch;
  late Timer _timer;
  DateTime? date;
  late ZikirProvider zikirProvider;

  //For textField which saving note
  final noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_stopwatch.isRunning) {
        updateElapsedTime();
      }
    });
    _stopwatch.start();
    Provider.of<NoteProvider>(context, listen: false).getAllNotes();
  }

  void updateElapsedTime() {
    if (mounted) {
      setState(() {}); // Trigger a rebuild
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    saveZikir(); // Cancel the timer to avoid calling setState after dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    zikirProvider = Provider.of<ZikirProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final zikirProvider = Provider.of<ZikirProvider>(context, listen: false);
    Duration duration = _stopwatch.elapsed;
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return Scaffold(
      resizeToAvoidBottomInset: false, // Disable automatic resizing
      body: Stack(
        children: [
          // Background Image
          AppBackgroundImageWidget(bgImagePath: AssetsPath.secondaryBGSVG),
          CustomAppbarWidget(screenTitle: 'tasbih_counter'.tr),
          Positioned(
            bottom: 0.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  widget.data,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: AppColors.colorAlert, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                _buildTime(hours, minutes, seconds),
                SizedBox(height: 30.h),
                _buildCounts(),
                SizedBox(height: 10.h),
                _buildSwiperCount(),
                SizedBox(height: 10.h),
                _buildBottomcontents(),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTime(int hours, int minutes, int seconds) {
    return Container(
      height: 40.h,
      width: 90.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.colorWhiteLowEmp.withOpacity(0.2)),
      child: Center(
        child: Text(
          '${hours > 0 ? '$hours:' : ''}${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(color: AppColors.colorWhiteHighEmp, fontSize: 20.sp),
        ),
      ),
    );
  }

  Widget _buildCounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'tasbih_counter'.tr,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeights.regular,
              color: AppColors.colorWhiteHighEmp),
        ),
        Text(
          '$countNumber',
          style: TextStyle(
              color: AppColors.colorAlert,
              fontSize: 100.sp,
              fontWeight: FontWeights.black),
        ),
        SizedBox(height: 60.h),
        Visibility(
          visible: countNumber == 0, // Set the condition to show/hide the Row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                Icons.arrow_back_ios,
                size: 18.h,
                color: AppColors.colorWhiteHighEmp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Swipe'.tr,
                style: TextStyle(
                  color: AppColors.colorWhiteHighEmp,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(width: 12.w),
               Icon(
                Icons.arrow_forward_ios,
                size: 18.h,
                color: AppColors.colorWhiteHighEmp,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwiperCount() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 75.h,
          width: 280.w,
          decoration: BoxDecoration(
            color: AppColors.colorBlack.withOpacity(.4),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Swiper(
            loop: true,
            scrollDirection: Axis.horizontal,
            duration: 800,
            itemCount: 100,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(width: 110.w),
                  Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Container(
                      height: 60.w,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.colorWhiteHighEmp,
                      ),
                    ),
                  ),
                ],
              );
            },
            onIndexChanged: (int demo) {
              setState(() {
                countNumber++;
              });
            },
          ),
        ),
      ),
    );
  }


  Widget _buildBottomcontents() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 8.h),
      child: Container(
        height: 85.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 40.h, right: 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    countNumber = 0;
                  });
                },
                child: Icon(
                  Icons.refresh,
                  color: AppColors.colorWhiteHighEmp,
                  size: 25.sp,
                ),
              ),
              InkWell(
                onTap: () {
                  _showSimpleDialogForAddNotes();
                },
                child: Icon(
                  Icons.save,
                  color: AppColors.colorWhiteHighEmp,
                  size: 22.sp,
                ),
              ),
              InkWell(
                onTap: () {
                  _showSimpleDialogForAllNotes();
                },
                child: Icon(
                  Icons.history,
                  color: AppColors.colorWhiteHighEmp,
                  size: 25.sp,
                ),
              ),
              InkWell(
                onTap: () {
                  saveZikir();
                  secondaryCountNumber = countNumber;
                  Get.to(const TasbihCountSummaryScreen());
                },
                child: Icon(
                  Icons.bar_chart,
                  color: AppColors.colorWhiteHighEmp,
                  size: 22.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Dialog for adding notes
  Future<void> _showSimpleDialogForAddNotes() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.colorWhiteHighEmp,
          child: SizedBox(
            height: 420.h,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: SvgPicture.asset(
                      AssetsPath.popupBGSVG,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'what_are_you_reading'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.colorBlackHighEmp,
                      fontWeight: FontWeights.semiBold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: noteController,
                          decoration: InputDecoration(
                              hintText: 'subhanallah_33_times'.tr,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: AppColors.colorWhiteLowEmp,
                                      width: 1))),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this_field_must_not_be_empty'.tr;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      saveNote();
                      Navigator.pop(context);
                      showMsg(context, 'added_successfully'.tr);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 80, right: 80),
                      height: 36.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.colorButtonGradientStart,
                            AppColors.colorButtonGradientEnd,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          'add'.tr,
                          style: TextStyle(
                              color: AppColors.colorBlackHighEmp,
                              fontSize: 14.sp,
                              fontWeight: FontWeights.semiBold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'close'.tr,
                          style: TextStyle(
                              color: AppColors.colorDisabled,
                              fontSize: 14.sp,
                              fontWeight: FontWeights.regular),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///Dialog for showing saved notes
  Future<void> _showSimpleDialogForAllNotes() async {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.colorWhiteHighEmp,
          child: SizedBox(
            height: 500.h,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: SvgPicture.asset(
                    AssetsPath.popupBGSVG,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'tasbih_note'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.colorBlackHighEmp,
                    fontWeight: FontWeights.semiBold,
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 120.h,
                  child: Consumer<NoteProvider>(
                    builder: (context, provider, child) => ListView.builder(
                      itemCount: provider.noteList.length,
                      itemBuilder: (context, index) {
                        final note = provider.noteList[index];
                        return Column(
                          children: [
                            Container(
                              height: 30.h,
                              margin: EdgeInsets.symmetric(horizontal: 24.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: AppColors.colorWhiteLowEmp),
                              ),
                              child: Center(
                                child: Text(
                                  note.note,
                                  style: TextStyle(
                                    color: AppColors.colorBlackHighEmp,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeights.regular,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {
                    deleteNotes(context, noteProvider);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 80.w, right: 80.w),
                    height: 36.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.colorButtonGradientStart,
                          AppColors.colorButtonGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        'clear_note'.tr,
                        style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeights.semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'close'.tr,
                      style: TextStyle(
                        color: AppColors.colorDisabled,
                        fontSize: 14.sp,
                        fontWeight: FontWeights.regular,
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

  //Method for save notes
  void saveNote() {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      final note = NoteModel(note: noteController.text);
      noteProvider.insertNote(note).then((value) {
        noteProvider.getAllNotes();
        noteController.clear();
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  //Method for delete exiting notes
  void deleteNotes(BuildContext context, NoteProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.colorPrimary,
        title: Text(
          'clear_all_notes'.tr,
          style: const TextStyle(color: AppColors.colorAlert),
        ),
        content: Text(
          'are_you_sure_to_clear_all_notes'.tr,
          style: const TextStyle(color: AppColors.colorWhiteHighEmp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'no'.tr,
              style: const TextStyle(color: AppColors.colorWhiteHighEmp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              provider.deleteNotes().then((value) {
                Navigator.pop(context);
                provider.getAllNotes();
              });
            },
            child: Text(
              'yes'.tr,
              style: const TextStyle(color: AppColors.colorAlert),
            ),
          )
        ],
      ),
    );
  }

  //Method for save count
  void saveZikir() {
    date = DateTime.now();
    final zikir = ZikirModel(
        date: getFormattedDate(date!, 'dd/MM/yyyy'),
        name: widget.data,
        count: countNumber - secondaryCountNumber);
    zikirProvider.insertZikir(zikir).then((value) {
      zikirProvider.getAllZikirs();
    }).catchError((error) {
      print(error.toString());
    });
  }
}

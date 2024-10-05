import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/fonts_weights.dart';

class CustomAppbarWidget extends StatelessWidget {
  const CustomAppbarWidget({
    Key? key,
    required this.screenTitle,
    this.backButton = true,
  }) : super(key: key);

  final String screenTitle;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: backButton ? 34 : 50,
      ),
      child: Row(
        mainAxisAlignment: backButton ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          if (backButton)
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.colorWhiteHighEmp,
              ),
            ),
          if (!backButton) Spacer(),
          Expanded(
            child: Text(
              screenTitle.tr,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 16.sp,
                fontFamily: 'Barlow',
                fontWeight: FontWeights.semiBold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!backButton) Spacer(),
        ],
      ),
    );
  }
}

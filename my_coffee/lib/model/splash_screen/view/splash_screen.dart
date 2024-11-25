// ignore_for_file: library_private_types_in_public_api

import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenController mSplashScreenController;

  @override
  void initState() {
    super.initState();
    mSplashScreenController =
        Get.put<SplashScreenController>(SplashScreenController());
    mSplashScreenController.initSharedPreferencesInstance();
    mSplashScreenController.getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarsCommon.appNoBar(),
        body: SafeArea(
          child: _buildSplashScreenView(),
          bottom: false,
        ));
  }

  _buildSplashScreenView() {
    return FocusDetector(
        onVisibilityGained: () {
          mSplashScreenController.nextPage();
        },
        onVisibilityLost: () {
          Get.delete<SplashScreenController>();
        },
        child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageAssetsConstants.appLogo,
                    width: 40.w,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    ImageAssetsConstants.buttonLogo,
                    width: 40.w,
                    fit: BoxFit.contain,
                  ),
                ),
                Obx(() {
                  return Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 15.sp),
                      child: Text(
                        '${sVersion.tr} ${mSplashScreenController.version.value}',
                        style: getTextRegular(
                            size: 15.sp, colors: ColorConstants.appVersion),
                      ));
                }),
              ],
            )));
  }
}


import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/common/button_constants.dart';
import 'package:f_b_base/common/text_input_widget.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/pattern_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../otp_screen/controller/otp_controller.dart';
import '../controller/register_screen_controller.dart';

class RegisterScreenScreen extends GetView<RegisterScreenController> {
  const RegisterScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegisterScreenController());
    return Scaffold(
        appBar: AppBarsCommon.appBarBack(title: sLoginOrSignUp.tr),
        body: SafeArea(bottom: false, child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          if (Get.isRegistered<OtpScreenController>()) {
            Get.delete<OtpScreenController>();
          }
        },
        onVisibilityLost: () {},
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorConstants.primaryBackgroundColor,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        ImageAssetsConstants.buttonLogo,
                        width: 40.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    mLoginView(),
                  ],
                ))));
  }

  mLoginView() {
    return Obx(
      () {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 18.sp,
              ),
              Container(
                height: 20.sp,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  ImageAssetsConstants.appLogo,
                  width: 25.w,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 20.sp,
              ),

              ///Enter user Name number
              Container(
                height: 29.5.sp,
                padding: EdgeInsets.all(11.sp),
                margin: EdgeInsets.only(
                    left: 28.sp, right: 28.sp, bottom: 13.sp, top: 15.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.22),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ], // use instead of BorderRadius.all(Radius.circular(20))
                ),
                child: TextInputWidget(
                  controller: controller.nameController.value,
                  showFloatingLabel: false,
                  isPhone: false,
                  prefixImage: ImageAssetsConstants.edit1,
                  placeHolder: sEnterYourName.tr,
                  hintText: sEnterYourName.tr,
                  topPadding: 1.sp,
                  errorText: null,
                  prefixHeight: 27.5.sp,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                        RegExp(AppUtilConstants.patternStringAndSpace)),
                  ],
                ),
              ),

              ///Enter Email id
              Container(
                height: 29.5.sp,
                padding: EdgeInsets.all(12.5.sp),
                margin: EdgeInsets.only(
                    left: 28.sp, right: 28.sp, bottom: 18.5.sp, top: 13.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.22),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ], // use instead of BorderRadius.all(Radius.circular(20))
                ),
                child: TextInputWidget(
                  controller: controller.emailController.value,
                  showFloatingLabel: false,
                  isPhone: false,
                  prefixImage: ImageAssetsConstants.edit2,
                  placeHolder: sEmailIdHint.tr,
                  hintText: sEmailIdHint.tr,
                  errorText: null,
                  topPadding: 1.sp,
                  prefixHeight: 27.5.sp,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                        RegExp(AppUtilConstants.patternEmailStringAtDot)),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                  left: 28.sp,
                  right: 28.sp,
                ),
                child: rectangleRoundedCornerButton(
                  'Register',
                  () {
                    controller.isRegister();
                  },
                  bgColor: ColorConstants.cAppColorsBlue,
                  textColor: Colors.white,
                  height: 28.sp,
                  size: 17.sp
                ),
              ),
              // By Logging in or registering, you agree to our Terms of Service, Privacy Policy and  Personal Data Protection Policy
              Container(
                  margin: EdgeInsets.only(
                      left: 28.sp, right: 28.sp, top: 20.sp, bottom: 20.sp),
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By Logging in or registering, you agree to our\n',
                      style: getTextRegularNoHeights(
                          size: 15.sp, colors: ColorConstants.buttonBar),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Terms of Service, Privacy Policy ',
                            style: getTextRegularNoHeights(
                                size: 15.sp,
                                colors: ColorConstants.cAppColorsBlue)),
                        const TextSpan(text: 'and\n'),
                        TextSpan(
                            text: 'Personal Data Protection Policy',
                            style: getTextRegularNoHeights(
                                size: 15.sp,
                                colors: ColorConstants.cAppColorsBlue)),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

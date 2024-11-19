import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import '../../../common/appbars_common.dart';
import '../../../common/button_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/pattern_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../../utils/app_utils.dart';
import '../controller/otp_controller.dart';

class OtpScreen extends GetView<OtpScreenController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OtpScreenController());
    return Scaffold(
        appBar: AppBarsCommon.appBarBack(title: sLoginOrSignUp.tr),
        body: SafeArea(bottom: false, child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          controller.startTimer();
        },
        onVisibilityLost: () {
          //controller.dispose();
        },
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
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: 33.sp, right: 33.sp, bottom: 16.5.sp, top: 20.sp),
                child: Text(
                  'Enter the Verification Code we sent to your registered phone number +${controller.mLoginScreenController.phoneCode.value}${controller.mLoginScreenController.mobileNumberController.value.text}',
                  textAlign: TextAlign.center,
                  style: getTextRegular(size: 15.sp, colors: Colors.grey),
                ),
              ),

              ///Enter otp number
              Pinput(
                defaultPinTheme: controller.defaultPinTheme,
                keyboardType: TextInputType.number,
                length: 6,
                separatorBuilder: (index) => const SizedBox(width: 8),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(AppUtilConstants.patternOnlyNumber),
                  ),
                ],
                validator: (value) {},
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                  controller.verificationCode(pin);
                },
                onChanged: (value) {
                  controller.otpValue.value = '';
                  controller.showValue.value = false;
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: ColorConstants.black,
                    ),
                  ],
                ),
                focusedPinTheme: controller.defaultPinTheme.copyWith(
                  decoration: controller.defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorConstants.black),
                  ),
                ),
                submittedPinTheme: controller.defaultPinTheme.copyWith(
                  decoration: controller.defaultPinTheme.decoration!.copyWith(
                    color: ColorConstants.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorConstants.black),
                  ),
                ),
                errorPinTheme: controller.defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
              SizedBox(
                height: 16.5.sp,
              ),
              Visibility(
                visible: controller.start.value != 0.0,
                child: Container(
                    margin: EdgeInsets.only(left: 32.5.sp, right: 32.5.sp),
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Resent otp in ',
                        style: getTextRegular(
                            size: 15.sp, colors: ColorConstants.buttonBar),
                        children: <TextSpan>[
                          TextSpan(
                              text: controller.start.toStringAsFixed(2),
                              style: getText600(
                                  size: 15.sp,
                                  colors: ColorConstants.cAppColorsBlue)),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 16.5.sp,
              ),
              Visibility(
                  visible: controller.start.value == 0.0,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 33.sp,
                      right: 33.sp,
                    ),
                    child: rectangleRoundedCornerButtonMedium('RESENT OTP', () {
                      controller.start.value = 1.59;
                      controller.startTimer();
                      controller.reSentApiCall();
                    },
                        bgColor: ColorConstants.buttonBar,
                        textColor: Colors.white,
                        height: 28.sp,
                        size: 17.sp),
                  )),
              SizedBox(
                height: controller.start.value == 0.0 ? 15.sp : 0.sp,
              ),
              Visibility(
                  visible: controller.showValue.value,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 33.sp,
                      right: 33.sp,
                    ),
                    child: rectangleRoundedCornerButtonBold('SUBMIT', () {
                      controller.otpSentApiCall();
                    },
                        bgColor: ColorConstants.cAppColorsBlue,
                        textColor: Colors.white,
                        height: 28.sp,
                        size: 17.sp),
                  )),
            ],
          ),
        );
      },
    );
  }
}

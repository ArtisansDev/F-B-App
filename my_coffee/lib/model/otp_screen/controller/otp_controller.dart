// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/login/login_request.dart';
import 'package:f_b_base/data/mode/login/login_response.dart';
import 'package:f_b_base/data/mode/verify_otp/verify_otp_request.dart';
import 'package:f_b_base/data/mode/verify_otp/verify_otp_response.dart';
import 'package:f_b_base/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/get_user_details.dart';
import '../../../routes/route_constants.dart';
import '../../login_screen/controller/login_controller.dart';

class OtpScreenController extends GetxController {
  RxString otpValue = ''.obs;
  RxBool showValue = false.obs;
  LoginScreenController mLoginScreenController =
      Get.find<LoginScreenController>();
  final defaultPinTheme = PinTheme(
    width: 26.sp,
    height: 26.sp,
    textStyle: getText500(colors: ColorConstants.black, size: 18.sp),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: ColorConstants.buttonBar.withOpacity(0.5)),
    ),
  );
  final localApi = locator.get<UserAuthenticationApi>();

  void verificationCode(String verificationCode) {
    otpValue.value = verificationCode;
    if (verificationCode.length == 6) {
      showValue.value = true;
    }
  }

  Timer? _timer; // Timer object
  RxDouble start = 1.19.obs; // Initial countdown value (10 seconds)

  // Start the timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start.value == 1.00) {
        start.value = 0.59;
      } else if (start.value > 0) {
        start.value = getDoubleValue(start.value - 0.01);
      } else {
        _timer?.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  void dispose() {
    // if (_timer != null) {
    _timer?.cancel(); // Clean up the timer when the widget is disposed
    // }
    super.dispose();
  }

  ///otp-sent ApiCall
  void otpSentApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        VerifyOtpRequest mVerifyOtpRequest = VerifyOtpRequest(
            phoneNumber:
                mLoginScreenController.mobileNumberController.value.text,
            countryCode: '+${mLoginScreenController.phoneCode}',
            otp: otpValue.value);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postVerifyOTP(mVerifyOtpRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          VerifyOtpResponse mVerifyOtpResponse = mWebResponseSuccess.data;
          if (mVerifyOtpResponse.statusCode == WebConstants.statusCode200) {
            AppAlertBase.showSnackBar(
                Get.context!, mVerifyOtpResponse.statusMessage ?? "");
            if ((mVerifyOtpResponse.data?.isRegister ?? 0) == 1) {
              await SharedPrefs()
                  .setUserToken(mVerifyOtpResponse.data?.accessToken ?? '');
              await SharedPrefs()
                  .setUserId(mVerifyOtpResponse.data?.userId ?? '');
              Future.delayed(const Duration(milliseconds: 500), () {});
              await getUserDetails();
              Get.until((route) {
                return route.settings.name ==
                        RouteConstants.rOrderConfirmationScreen ||
                    route.settings.name ==
                        RouteConstants
                            .rDashboardScreen; // Goes back until reaching '/dashboard'
              });
            } else {
              Get.offNamed(
                RouteConstants.rRegisterScreenScreen,
              );
            }
          } else {
            AppAlertBase.showSnackBar(
                Get.context!, mVerifyOtpResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  ///re-sent ApiCall
  void reSentApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        LoginRequest mLoginRequest = LoginRequest(
            phoneNumber:
                mLoginScreenController.mobileNumberController.value.text,
            countryCode: '+${mLoginScreenController.phoneCode}');
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postLogin(mLoginRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          LoginResponse mLoginResponse = mWebResponseSuccess.data;
          if (mLoginResponse.statusCode == WebConstants.statusCode200) {
            AppAlertBase.showSnackBar(
                Get.context!, mLoginResponse.statusMessage ?? "");
          } else {
            AppAlertBase.showSnackBar(
                Get.context!, mLoginResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

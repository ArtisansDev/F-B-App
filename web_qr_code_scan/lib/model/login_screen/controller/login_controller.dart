import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/login/login_request.dart';
import 'package:f_b_base/data/mode/login/login_response.dart';
import 'package:f_b_base/data/mode/verify_otp/verify_otp_response.dart';
import 'package:f_b_base/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/get_web_info.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/get_user_details.dart';
import '../../../routes/route_constants.dart';

class LoginScreenController extends GetxController {
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  RxString gender = ''.obs;
  RxString phoneCode = '60'.obs;
  final localApi = locator.get<UserAuthenticationApi>();

  isLogin(String sValue) {
    if (mobileNumberController.value.text.trim().isEmpty) {
      AppAlertBase.showSnackBar(Get.context!, sPleaseEnterMobileNumber.tr);
    } else if (mobileNumberController.value.text.trim().length < 9) {
      AppAlertBase.showSnackBar(Get.context!, sPleaseEnterValidMobileNumber.tr);
    } else {
      loginApiCall();
    }
  }

  void loginApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        LoginRequest mLoginRequest = LoginRequest(
          restaurantIDF:
              (await SharedPrefs().getGeneralSetting()).restaurantIDF ?? '',
          phoneNumber: mobileNumberController.value.text,
          countryCode: '+$phoneCode',
        );
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postLogin(mLoginRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          LoginResponse mLoginResponse = mWebResponseSuccess.data;
          if (mLoginResponse.statusCode == WebConstants.statusCode200) {
            AppAlertBase.showSnackBar(
                Get.context!, mLoginResponse.statusMessage ?? "");

            Get.toNamed(RouteConstants.rOtpScreen);
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

  void isGuest() async{
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGuestLogin();
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          VerifyOtpResponse mVerifyOtpResponse = mWebResponseSuccess.data;
          if (mVerifyOtpResponse.statusCode == WebConstants.statusCode200) {
            AppAlertBase.showSnackBar(
                Get.context!, mVerifyOtpResponse.statusMessage ?? "");
            await SharedPrefs()
                .setUserToken(mVerifyOtpResponse.data?.accessToken ?? '');
            await SharedPrefs()
                .setUserId(mVerifyOtpResponse.data?.userId ?? '');
            await SharedPrefs().guestUser(true);
            if(kIsWeb) {
              await getWebView();
            }
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
            AppAlertBase.showSnackBar(
                Get.context!, mVerifyOtpResponse.statusMessage ?? "");
          }
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? "");
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

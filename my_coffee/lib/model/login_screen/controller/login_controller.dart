import 'package:f_b_base/alert/app_alert.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/mode/login/login_request.dart';
import 'package:f_b_base/data/mode/login/login_response.dart';
import 'package:f_b_base/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            phoneNumber: mobileNumberController.value.text,
            countryCode: '+$phoneCode');
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
}

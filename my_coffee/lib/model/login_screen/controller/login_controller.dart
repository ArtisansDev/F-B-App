import 'package:my_coffee/alert/app_alert.dart';
import 'package:my_coffee/alert/app_alert_base.dart';
import 'package:my_coffee/constants/message_constants.dart';
import 'package:my_coffee/constants/web_constants.dart';
import 'package:my_coffee/data/mode/login/login_request.dart';
import 'package:my_coffee/data/mode/login/login_response.dart';
import 'package:my_coffee/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:my_coffee/data/remote/web_response.dart';
import 'package:my_coffee/lang/translation_service_key.dart';
import 'package:my_coffee/locator.dart';
import 'package:my_coffee/utils/network_utils.dart';
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

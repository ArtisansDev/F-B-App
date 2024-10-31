import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/mode/login/login_request.dart';
import '../../../data/mode/login/login_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../lang/translation_service_key.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/network_utils.dart';

class LoginScreenController extends GetxController {
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  RxString gender = ''.obs;
  RxString phoneCode = '60'.obs;

  isLogin(String sValue) {
    if (mobileNumberController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterMobileNumber.tr);
    } else if (mobileNumberController.value.text.trim().length < 9) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterValidMobileNumber.tr);
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
            await AllApiImpl().postLogin(mLoginRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          LoginResponse mLoginResponse = mWebResponseSuccess.data;
          if (mLoginResponse.statusCode == WebConstants.statusCode200) {
            AppAlert.showSnackBar(
                Get.context!, mLoginResponse.statusMessage ?? "");

            Get.toNamed(RouteConstants.rOtpScreen);
          } else {
            AppAlert.showSnackBar(
                Get.context!, mLoginResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

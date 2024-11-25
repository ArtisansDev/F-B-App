import 'package:my_coffee/alert/app_alert.dart';
import 'package:my_coffee/alert/app_alert_base.dart';
import 'package:my_coffee/constants/message_constants.dart';
import 'package:my_coffee/constants/web_constants.dart';
import 'package:my_coffee/data/local/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/data/mode/register/register_request.dart';
import 'package:my_coffee/data/mode/register/register_response.dart';
import 'package:my_coffee/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:my_coffee/data/remote/web_response.dart';
import 'package:my_coffee/lang/translation_service_key.dart';
import 'package:my_coffee/locator.dart';
import 'package:my_coffee/utils/app_utils.dart';
import 'package:my_coffee/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/get_user_details.dart';
import '../../../routes/route_constants.dart';
import '../../login_screen/controller/login_controller.dart';

class RegisterScreenController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  LoginScreenController mLoginScreenController =
      Get.find<LoginScreenController>();
  final localApi = locator.get<UserAuthenticationApi>();

  isRegister() {
    if (nameController.value.text.trim().isEmpty) {
      AppAlertBase.showSnackBar(Get.context!, 'Please enter your name');
    } else if (emailController.value.text.trim().isEmpty) {
      AppAlertBase.showSnackBar(Get.context!, sUsernameHint.tr);
    } else if (AppUtils.isValidEmail(emailController.value.text.trim())) {
      AppAlertBase.showSnackBar(Get.context!, sUsernameErrorValid.tr);
    } else {
      registerApiCall();
    }
  }

  void registerApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        RegisterRequest mRegisterRequest = RegisterRequest(
            phoneNumber:
                mLoginScreenController.mobileNumberController.value.text,
            countryCode: '+${mLoginScreenController.phoneCode}',
            email: emailController.value.text,
            firstName: nameController.value.text,
            lastName: '');
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postRegister(mRegisterRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          RegisterResponse mRegisterResponse = mWebResponseSuccess.data;
          if (mRegisterResponse.statusCode == WebConstants.statusCode200) {
            AppAlertBase.showSnackBar(
                Get.context!, mRegisterResponse.statusMessage ?? "");
            if ((mRegisterResponse.data?.isRegister ?? 0) == 1) {
              await SharedPrefs()
                  .setUserToken(mRegisterResponse.data?.accessToken ?? '');
              await SharedPrefs()
                  .setUserId(mRegisterResponse.data?.userId ?? '');
              await getUserDetails();
              // if (Get.isRegistered<DashboardScreenController>()) {
              //   DashboardScreenController mDashboardScreenController =
              //       Get.find<DashboardScreenController>();
              //   mDashboardScreenController.selectedIndex.value = 0;
              // }
              // Get.offAllNamed(
              //   RouteConstants.rDashboardScreen,
              // );
              Get.until((route) {
                return route.settings.name ==
                    RouteConstants
                        .rDashboardScreen; // Goes back until reaching '/dashboard'
              });
            } else {
              // Get.offNamed(RouteConstants.rRegisterScreenScreen,);
            }
          } else {
            AppAlertBase.showSnackBar(
                Get.context!, mRegisterResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

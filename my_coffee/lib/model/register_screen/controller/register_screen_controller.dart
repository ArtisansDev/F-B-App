import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/register/register_request.dart';
import 'package:f_b_base/data/mode/register/register_response.dart';
import 'package:f_b_base/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:f_b_base/utils/network_utils.dart';
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
            lastName: '',
            restaurantIDF:
                (await SharedPrefs().getGeneralSetting()).restaurantIDF ?? '');
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
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode409) {
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

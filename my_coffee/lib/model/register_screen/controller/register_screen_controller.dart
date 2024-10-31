import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/get_user_details.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/login/login_request.dart';
import '../../../data/mode/login/login_response.dart';
import '../../../data/mode/register/register_request.dart';
import '../../../data/mode/register/register_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../lang/translation_service_key.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/network_utils.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../login_screen/controller/login_controller.dart';

class RegisterScreenController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  LoginScreenController mLoginScreenController =
      Get.find<LoginScreenController>();

  isRegister() {
    if (nameController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, 'Please enter your name');
    } else if (emailController.value.text.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, sUsernameHint.tr);
    } else if (AppUtils.isValidEmail(emailController.value.text.trim())) {
      AppAlert.showSnackBar(Get.context!, sUsernameErrorValid.tr);
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
            await AllApiImpl().postRegister(mRegisterRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          RegisterResponse mRegisterResponse = mWebResponseSuccess.data;
          if (mRegisterResponse.statusCode == WebConstants.statusCode200) {
            AppAlert.showSnackBar(
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
            AppAlert.showSnackBar(
                Get.context!, mRegisterResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

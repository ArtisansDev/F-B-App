import 'dart:convert';
import 'dart:io';

import 'package:f_b_base/alert/app_alert.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/get_general_setting/get_general_setting_response.dart';
import 'package:f_b_base/data/remote/api_call/general_api/general_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../../../routes/route_constants.dart';

class SplashScreenController extends GetxController {
  RxString version = ''.obs;
  final localApi = locator.get<GeneralApi>();

  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
  }

  initSharedPreferencesInstance() async {
    await SharedPrefs().sharedPreferencesInstance();
  }

  nextPage() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        await Future.delayed(const Duration(seconds: 2));
        //generalSettingApiCall();
        Get.offNamed(
          RouteConstants.rIntroductionScreen,
        );
      }
    });
  }

  ///generalSettingApiCall
  void generalSettingApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess =
        await localApi.getGeneralSetting();
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetGeneralSettingResponse mGetGeneralSettingResponse =
              mWebResponseSuccess.data;
          if (mGetGeneralSettingResponse.statusCode ==
              WebConstants.statusCode200) {
            if ((mGetGeneralSettingResponse.data ?? []).isNotEmpty) {
              GetGeneralSettingData mGetGeneralSettingData =
                  (mGetGeneralSettingResponse.data ?? []).first;
              bool bNextPage = false;
              String value = '';
              if (Platform.isAndroid) {
                if (mGetGeneralSettingData.isAndroidEnable ?? false) {
                  bNextPage = true;
                } else {
                  value = 'This variation is not supported in android';
                }
              } else if (Platform.isIOS) {
                if (mGetGeneralSettingData.isIOSEnable ?? false) {
                  bNextPage = true;
                } else {
                  value = 'This variation is not supported in ios';
                }
              }
              // if (bNextPage) {
              await SharedPrefs()
                  .setGeneralSetting(jsonEncode(mGetGeneralSettingData));
              Get.offNamed(
                RouteConstants.rDashboardScreen,
              );
              // }else {
              //   AppAlertBase.showSnackBar(
              //       Get.context!,  value);
              // }
            } else {
              AppAlertBase.showSnackBar(
                  Get.context!, mGetGeneralSettingResponse.statusMessage ?? "");
            }
          } else {
            AppAlertBase.showSnackBar(
                Get.context!, mGetGeneralSettingResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

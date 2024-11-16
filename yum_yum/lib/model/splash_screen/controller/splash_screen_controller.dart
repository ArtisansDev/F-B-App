import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/get_general_setting/get_general_setting_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/network_utils.dart';

class SplashScreenController extends GetxController {
  RxString version = ''.obs;

  getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
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
        await AllApiImpl().getGeneralSetting();
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
              //   AppAlert.showSnackBar(
              //       Get.context!,  value);
              // }
            } else {
              AppAlert.showSnackBar(
                  Get.context!, mGetGeneralSettingResponse.statusMessage ?? "");
            }
          } else {
            AppAlert.showSnackBar(
                Get.context!, mGetGeneralSettingResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

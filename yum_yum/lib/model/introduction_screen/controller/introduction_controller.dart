// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/get_general_setting/get_general_setting_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/get_address.dart';
import '../../../utils/get_location.dart';
import '../../../utils/network_utils.dart';

class IntroductionScreenController extends GetxController {
  final PageController introductionPageController =
      PageController(initialPage: 0);
  GetLocation mGetLocation = GetLocation();

  void onChangePage(int value) {}
  Rx<LatLng> centerLatLng = const LatLng(0, 0).obs;

  void goToNextPage() {
    // mGetLocation.checkLocationPermission((Position position) async {
    //   centerLatLng.value = LatLng(position.latitude, position.longitude);
    //
    //   ///Get Location
    //   AppAlert.showSnackBar(Get.context!,
    //       ' Longitude:${position.longitude} Latitude:${position.latitude}');
    //   var sCountry =
    //       await getCountryFromLatLng(position.latitude, position.longitude);
    //   AppAlert.showSnackBar(Get.context!, 'sCountry: $sCountry ');
    //
    //   generalSettingApiCall();
    // });

    generalSettingApiCall();
  }

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
              if ((mGetGeneralSettingData.restaurantIDF ?? '').isNotEmpty) {
                await SharedPrefs()
                    .setGeneralSetting(jsonEncode(mGetGeneralSettingData));
                Get.offNamed(
                  RouteConstants.rDashboardScreen,
                );
              } else {
                AppAlert.showSnackBar(Get.context!, 'restaurant id not found');
              }
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

/*
 * Project      : skill_360
 * File         : logout.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-08-16
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:convert';

import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/user_delete/user_delete_request.dart';
import 'package:f_b_base/data/mode/user_delete/user_delete_response.dart';
import 'package:f_b_base/data/mode/user_details/user_details_request.dart';
import 'package:f_b_base/data/mode/user_details/user_details_response.dart';
import 'package:f_b_base/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:get/get.dart';
import 'package:my_coffee/constants/logout_expired.dart';

Future<bool> getUserDetails() async {
  final localApi = locator.get<UserAuthenticationApi>();
  return await NetworkUtils()
      .checkInternetConnection()
      .then((isInternetAvailable) async {
    if (isInternetAvailable) {
      UserDetailsRequest mUserDetailsRequest =
          UserDetailsRequest(id: await SharedPrefs().getUserId());
      WebResponseSuccess mWebResponseSuccess =
          await localApi.postGetUserData(mUserDetailsRequest);
      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        UserDetailsResponse mUserDetailsResponse = mWebResponseSuccess.data;
        if (mUserDetailsResponse.statusCode == WebConstants.statusCode200) {
          await SharedPrefs()
              .setUserDetails(jsonEncode(mUserDetailsResponse.data ?? ''));
          return true;
        } else {
          logout();
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, mWebResponseSuccess.statusMessage ?? '');
        logout();
      }
      return false;
    } else {
      AppAlertBase.showSnackBar(
          Get.context!, MessageConstants.noInternetConnection);
      return false;
    }
  });
}

Future<bool> getUserDelete() async {
  final localApi = locator.get<UserAuthenticationApi>();
  return await NetworkUtils()
      .checkInternetConnection()
      .then((isInternetAvailable) async {
    if (isInternetAvailable) {
      UserDeleteRequest mUserDeleteRequest =
          UserDeleteRequest(id: await SharedPrefs().getUserId());
      WebResponseSuccess mWebResponseSuccess =
          await localApi.postUserDelete(mUserDeleteRequest);
      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        UserDeleteResponse mUserDeleteResponse = mWebResponseSuccess.data;
        if (mUserDeleteResponse.statusCode == WebConstants.statusCode200) {
          AppAlertBase.showSnackBar(
              Get.context!, mUserDeleteResponse.statusMessage ?? '');
          logout();
          return true;
        } else {
          logout();
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, mWebResponseSuccess.statusMessage ?? '');
        logout();
      }
      return false;
    } else {
      AppAlertBase.showSnackBar(
          Get.context!, MessageConstants.noInternetConnection);
      return false;
    }
  });
}

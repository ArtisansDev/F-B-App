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

import 'package:get/get.dart';
import 'package:my_coffee/constants/logout_expired.dart';
import 'package:my_coffee/constants/web_constants.dart';
import '../alert/app_alert.dart';
import '../data/local/shared_prefs/shared_prefs.dart';
import '../data/mode/user_delete/user_delete_request.dart';
import '../data/mode/user_delete/user_delete_response.dart';
import '../data/mode/user_details/user_details_request.dart';
import '../data/mode/user_details/user_details_response.dart';
import '../data/remote/api_call/api_impl.dart';
import '../data/remote/web_response.dart';
import '../utils/network_utils.dart';
import 'message_constants.dart';

Future<bool> getUserDetails() async {
  return await NetworkUtils()
      .checkInternetConnection()
      .then((isInternetAvailable) async {
    if (isInternetAvailable) {
      UserDetailsRequest mUserDetailsRequest =
          UserDetailsRequest(id: await SharedPrefs().getUserId());
      WebResponseSuccess mWebResponseSuccess =
          await AllApiImpl().postGetUserData(mUserDetailsRequest);
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
        AppAlert.showSnackBar(
            Get.context!, mWebResponseSuccess.statusMessage ?? '');
        logout();
      }
      return false;
    } else {
      AppAlert.showSnackBar(
          Get.context!, MessageConstants.noInternetConnection);
      return false;
    }
  });
}

Future<bool> getUserDelete() async {
  return await NetworkUtils()
      .checkInternetConnection()
      .then((isInternetAvailable) async {
    if (isInternetAvailable) {
      UserDeleteRequest mUserDeleteRequest =
          UserDeleteRequest(id: await SharedPrefs().getUserId());
      WebResponseSuccess mWebResponseSuccess =
          await AllApiImpl().postUserDelete(mUserDeleteRequest);
      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        UserDeleteResponse mUserDeleteResponse = mWebResponseSuccess.data;
        if (mUserDeleteResponse.statusCode == WebConstants.statusCode200) {
          AppAlert.showSnackBar(
              Get.context!, mUserDeleteResponse.statusMessage ?? '');
          logout();
          return true;
        } else {
          logout();
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, mWebResponseSuccess.statusMessage ?? '');
        logout();
      }
      return false;
    } else {
      AppAlert.showSnackBar(
          Get.context!, MessageConstants.noInternetConnection);
      return false;
    }
  });
}

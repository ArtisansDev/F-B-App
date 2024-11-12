import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/get_order_history/get_order_history_request.dart';
import '../../../data/mode/order_place/order_place_request.dart';
import '../../../data/mode/user_details/user_details_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../utils/network_utils.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class HistoryScreenController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///getOrderPlaceApi
  void getOrderHistoryApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UserDetailsResponseData mUserDetailsResponseData =
            await SharedPrefs().getUserDetails();
        GetOrderHistoryRequest mGetOrderHistoryRequest =
            GetOrderHistoryRequest(userIDF: mUserDetailsResponseData.userID);
        WebResponseSuccess mWebResponseSuccess =
            await AllApiImpl().postGetOrderHistory(mGetOrderHistoryRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        } else {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

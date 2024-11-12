import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/get_order_history/get_order_history_request.dart';
import '../../../data/mode/get_order_history/order_history_response.dart';
import '../../../data/mode/order_place/order_place_request.dart';
import '../../../data/mode/user_details/user_details_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../utils/network_utils.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class HistoryScreenController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  RxString showValue = 'Loading...'.obs;
  RxList<OrderHistoryResponseItemData> mOrderHistoryResponseItemData =
      <OrderHistoryResponseItemData>[].obs;

  ///Refresh
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  RxBool enablePullUp = false.obs;
  int pageNumber = 1;

  void onRefresh() async {
    showValue.value = 'Loading...';
    mOrderHistoryResponseItemData.value.clear();
    pageNumber = 1;
    getOrderHistoryApi();
  }

  void onLoadMore() async {
    pageNumber = pageNumber + 1;
    getOrderHistoryApi();
  }

  ///getOrderPlaceApi
  void getOrderHistoryApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UserDetailsResponseData mUserDetailsResponseData =
            await SharedPrefs().getUserDetails();
        GetOrderHistoryRequest mGetOrderHistoryRequest =
            GetOrderHistoryRequest(userIDF: mUserDetailsResponseData.userID,
            pageNumber: pageNumber,
            rowsPerPage: 10);
        WebResponseSuccess mWebResponseSuccess =
            await AllApiImpl().postGetOrderHistory(mGetOrderHistoryRequest);
        if (refreshController.isRefresh) {
          refreshController.refreshCompleted();
        } else if (refreshController.isLoading) {
          refreshController.loadComplete();
        }
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          OrderHistoryResponse mOrderHistoryResponse = mWebResponseSuccess.data;
          mOrderHistoryResponseItemData.value.addAll((mOrderHistoryResponse.data?.data??[]).toList());
          if(mOrderHistoryResponseItemData.isEmpty){
            showValue.value ='No history found';
          }
          showValue.value ='';
          enablePullUp.value = mOrderHistoryResponseItemData.value.length <
              (mOrderHistoryResponse.data?.totalRecords ?? 0);
          mOrderHistoryResponseItemData.refresh();
        } else {
          showValue.value = 'Internal server error';
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        showValue.value = MessageConstants.noInternetConnection;
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

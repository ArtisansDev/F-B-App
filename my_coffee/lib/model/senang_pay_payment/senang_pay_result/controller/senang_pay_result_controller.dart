// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/get_order_history/get_order_history_request.dart';
import 'package:f_b_base/data/mode/get_order_history/order_history_response.dart';
import 'package:f_b_base/data/mode/update_payment_status/update_payment_status_request.dart';
import 'package:f_b_base/data/mode/user_details/user_details_response.dart';
import 'package:f_b_base/data/remote/api_call/order/order_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../routes/route_constants.dart';

class SenangPayResultController extends GetxController {
  RxString orderId = ''.obs;
  RxString transactionId = ''.obs;
  RxString msg = ''.obs;
  RxString sUrl = ''.obs;
  final localApi = locator.get<OrderHistoryApi>();

  void getUrlValue(String url) {
     sUrl.value = url;
     print("###### ${sUrl.value}");
    if (url.contains('localhost')) {
      if (url.split(':').length > 2) {
        url = url.split(':').first + '://' + url.split(':').last;
      }
    }
    debugPrint('transactionId : ${url}');
    if (url.contains('order_id')) {
      url = url.replaceAll('#', 'abcd');
      final uri = Uri.parse(url);
      orderId.value = uri.queryParameters['order_id'].toString();
      transactionId.value = uri.queryParameters['transaction_id'].toString();
      msg.value = uri.queryParameters['msg'].toString();
      getOrderHistoryApi();

      ///
    }
  }

  ///getOrderHistoryApi
  void getOrderHistoryApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UserDetailsResponseData mUserDetailsResponseData =
            await SharedPrefs().getUserDetails();
        GetOrderHistoryRequest mGetOrderHistoryRequest = GetOrderHistoryRequest(
            userIDF: mUserDetailsResponseData.userID,
            orderID: orderId.value,
            pageNumber: 1,
            rowsPerPage: 10);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGetOrderHistory(mGetOrderHistoryRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          OrderHistoryResponse mOrderHistoryResponse = mWebResponseSuccess.data;
          if ((mOrderHistoryResponse.data?.data ?? []).isEmpty) {
            orderId.value = 'No history found';
          } else {
            if (msg.value.contains("Payment_was_successful")) {
              await getUpdatePaymentStatusApi(
                  (mOrderHistoryResponse.data?.data ?? []).first);
            } else if (msg.value.contains("The_payment_was_declined")) {
              await getUpdatePaymentDeclinedApi(
                  (mOrderHistoryResponse.data?.data ?? []).first);
            }
          }
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  ///getSubmitPayment
  getUpdatePaymentStatusApi(
      OrderHistoryResponseItemData mOrderHistoryResponse) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UpdatePaymentStatusRequest mUpdatePaymentStatusRequest =
            UpdatePaymentStatusRequest(
                restaurantIDF: mOrderHistoryResponse.restaurantIDF,
                userID: mOrderHistoryResponse.userIDF,
                orderID: mOrderHistoryResponse.orderIDP,
                paymentGatewayIDF: mOrderHistoryResponse.paymentGatewayIDF,
                paymentGatewayNo:
                    (mOrderHistoryResponse.paymentGatewayNo ?? 0).toString(),
                paymentGatewaySettingIDF:
                    mOrderHistoryResponse.paymentGatewaySettingIDF,
                paymentStatus: 'S',
                responseCode: '200',
                responseData: sUrl.value.split('?').last,
                paidAmount: mOrderHistoryResponse.totalAmount,
                responseMessage: 'Transaction Successful',
                transactionID: transactionId.value);
        debugPrint(
            "mUpdatePaymentStatusRequest ${jsonEncode(mUpdatePaymentStatusRequest)}");
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdatePaymentStatus(mUpdatePaymentStatusRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          AppAlertBase.showCustomDialogOk(
              Get.context!, sPaymentSuccessful.tr, sPaymentSuccessfulMessage.tr,
              () {
            Get.offAllNamed(RouteConstants.rDashboardScreen);
          }, rightText: 'Ok');
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  getUpdatePaymentDeclinedApi(
      OrderHistoryResponseItemData mOrderHistoryResponse) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UpdatePaymentStatusRequest mUpdatePaymentStatusRequest =
            UpdatePaymentStatusRequest(
                restaurantIDF: mOrderHistoryResponse.restaurantIDF,
                userID: mOrderHistoryResponse.userIDF,
                orderID: mOrderHistoryResponse.orderIDP,
                paymentGatewayIDF: mOrderHistoryResponse.paymentGatewayIDF,
                paymentGatewayNo:
                    (mOrderHistoryResponse.paymentGatewayNo ?? 0).toString(),
                paymentGatewaySettingIDF:
                    mOrderHistoryResponse.paymentGatewaySettingIDF,
                paymentStatus: 'F',
                responseCode: '400',
                responseData: sUrl.value.split('?').last,
                paidAmount: mOrderHistoryResponse.totalAmount,
                responseMessage: 'Transaction Declined',
                transactionID: transactionId.value);
        debugPrint(
            "mUpdatePaymentStatusRequest ${jsonEncode(mUpdatePaymentStatusRequest)}");
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdatePaymentStatus(mUpdatePaymentStatusRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          AppAlertBase.showCustomDialogOk(
              Get.context!, sPaymentDeclined.tr, sPaymentDeclinedMessage.tr,
              () {
            Get.offAllNamed(RouteConstants.rDashboardScreen);
          }, rightText: 'Ok');
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

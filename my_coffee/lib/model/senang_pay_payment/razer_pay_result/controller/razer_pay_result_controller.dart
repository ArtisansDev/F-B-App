// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

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

class RazerPayResultController extends GetxController {
  RxString orderId = ''.obs;
  RxString transactionId = ''.obs;
  RxString status = ''.obs;

  // RxString msg = ''.obs;
  RxString sUrl = ''.obs;
  final localApi = locator.get<OrderHistoryApi>();

  void getUrlValue(String url) async {
    sUrl.value = url;
    if (url.contains('localhost')) {
      url = url.replaceAll("localhost:", "partha");
    }

    ///https://staging.artisanssolutions.com/Yum/#/razer_pay_result?skey=a4bace92c36c8ca7e06e96fe7bd75c19&tranID=30924785&domain=SB_ttgreen&status=00&amount=5.00&currency=MYR&paydate=2024-12-30+14:00:30&orderid=8bef4fe6-8a4f-4063-b68c-b4755099c9a2&appcode=123456&error_code&error_desc&channel=Credit&extraP={%22ccbrand%22:%22Visa%22,%22cclast4%22:%221111%22,%22cctype%22:%22Credit%22}
    // debugPrint('transactionId : ${url}');
    if (url.contains('orderid')) {
      url = url.replaceAll('#', 'abcd');
      final uri = Uri.parse(url);
      orderId.value = uri.queryParameters['orderid'].toString();
      transactionId.value = uri.queryParameters['tranID'].toString();
      status.value = uri.queryParameters['status'].toString();
      getOrderHistoryApi();
      ///
    }
  }

  ///getOrderHistoryApi
  void getOrderHistoryApi() {
    try {
      NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          UserDetailsResponseData mUserDetailsResponseData =
              await SharedPrefs().getUserDetails();
          GetOrderHistoryRequest mGetOrderHistoryRequest =
              GetOrderHistoryRequest(
                  userIDF: mUserDetailsResponseData.userID,
                  orderID: orderId.value,
                  pageNumber: 1,
                  rowsPerPage: 10);
          WebResponseSuccess mWebResponseSuccess =
              await localApi.postGetOrderHistory(mGetOrderHistoryRequest);

          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            OrderHistoryResponse mOrderHistoryResponse =
                mWebResponseSuccess.data;
            if ((mOrderHistoryResponse.data?.data ?? []).isEmpty) {
              orderId.value = 'No history found';
              orderId.refresh();
            } else {
              if (transactionId.isNotEmpty || status.value.toString() == "00") {
                await getUpdatePaymentStatusApi(
                    (mOrderHistoryResponse.data?.data ?? []).first);
              } else {
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
    } catch (e) {
      orderId.value = '${e.toString()}';
      orderId.refresh();
    }
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
              () async {
            await SharedPrefs().setProcessOrderId('');
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

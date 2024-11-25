


import 'package:my_coffee/data/remote/api_call/api_impl.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../local/shared_prefs/shared_prefs.dart';
import '../../../mode/get_order_history/order_history_response.dart';
import '../../../mode/order_place/process_order_response.dart';
import '../../../mode/payment_type/payment_type_response.dart';
import '../../web_response.dart';
import '../../web_response_failed.dart';
import 'order_api.dart';

class OrderHistoryApiImpl extends AllApiImpl with OrderHistoryApi {

  ///post OrderPlace
  @override
  Future<WebResponseSuccess> postOrderPlace(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionOrderPlace, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      ProcessOrderResponse mProcessOrderResponse =
      ProcessOrderResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mProcessOrderResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///GetOrderHistory
  @override
  Future<WebResponseSuccess> postGetOrderHistory(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetOrderHistory, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      OrderHistoryResponse mOrderHistoryResponse =
      OrderHistoryResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mOrderHistoryResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///Payment type
  @override
  Future<WebResponseSuccess> postPaymentType (
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionPostPaymentType, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      PaymentTypeResponse mPaymentTypeResponse =
      PaymentTypeResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mPaymentTypeResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }


  ///update Payment status
  @override
  Future<WebResponseSuccess> postUpdatePaymentStatus (
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionPostUpdatePaymentStatus, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      // PaymentTypeResponse mPaymentTypeResponse =
      // PaymentTypeResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mPaymentTypeResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }
}

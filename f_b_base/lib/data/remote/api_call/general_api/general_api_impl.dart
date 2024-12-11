

import 'dart:convert';

import 'package:f_b_base/data/remote/api_call/api_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert_base.dart';
import '../../../../constants/web_constants.dart';
import '../../../local/shared_prefs/shared_prefs.dart';
import '../../../mode/get_best_seller_item/get_best_seller_item_response.dart';
import '../../../mode/get_dashboard/get_dashboard_response.dart';
import '../../../mode/get_general_setting/get_general_setting_request.dart';
import '../../../mode/get_general_setting/get_general_setting_response.dart';
import '../../web_response.dart';
import '../../web_response_failed.dart';
import '../api_dio_provider.dart';
import 'general_api.dart';

class GeneralApiImpl extends AllApiImpl with GeneralApi {

  ///Get GeneralSetting
  @override
  Future<WebResponseSuccess> postGeneralSetting() async {
    AppAlertBase.showProgressDialog(Get.context!);
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetGeneralSetting, GetGeneralSettingRequest());
    AppAlertBase.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      GetGeneralSettingResponse mGetGeneralSettingResponse =
      // GetGeneralSettingResponse.fromJson(jsonDecode(cases.body.toString()));
      GetGeneralSettingResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetGeneralSettingResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }


  ///post GetBestSellerItem
  @override
  Future<WebResponseSuccess> postGetBestSellerItem(
      dynamic exhibitorsListRequest) async {
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetBestSellerItem, exhibitorsListRequest);
    AppAlertBase.hideLoadingDialog(Get.context!);
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
      GetBestSellerItemResponse mGetBestSellerItemResponse =
      GetBestSellerItemResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetBestSellerItemResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetDashboard
  @override
  Future<WebResponseSuccess> postGetDashboard(
      dynamic exhibitorsListRequest) async {
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetDashboard, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlertBase.hideLoadingDialog(Get.context!);
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
      GetDashboardResponse mGetDashboardResponse =
      GetDashboardResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetDashboardResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }
}

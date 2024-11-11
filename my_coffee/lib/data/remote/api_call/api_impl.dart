import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_coffee/alert/app_alert.dart';
import 'package:my_coffee/data/mode/login/login_response.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/web_constants.dart';
import '../../local/shared_prefs/shared_prefs.dart';
import '../../mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../mode/get_best_seller_item/get_best_seller_item_response.dart';
import '../../mode/get_category/get_category_response.dart';
import '../../mode/get_category_item/get_category_item_response.dart';
import '../../mode/get_dashboard/get_dashboard_response.dart';
import '../../mode/get_general_setting/get_general_setting_response.dart';
import '../../mode/get_item_details/get_item_details_response.dart';
import '../../mode/logout/logout_response.dart';
import '../../mode/profile_image/profile_image_update_request.dart';
import '../../mode/register/register_response.dart';
import '../../mode/user_address_update/user_update_address_response.dart';
import '../../mode/user_delete/user_delete_response.dart';
import '../../mode/user_details/user_details_response.dart';
import '../../mode/user_update/user_update_response.dart';
import '../../mode/verify_otp/verify_otp_response.dart';
import '../web_response.dart';
import '../web_response_failed.dart';
import 'api_adapter.dart';
import 'api_dio_provider.dart';
import 'api_provider.dart';

class AllApiImpl implements IApiRepository {
  WebProvider mWebProvider = WebProvider();
  late WebResponseSuccess mWebResponseSuccess;
  late WebResponseFailed mWebResponseFailed;

  Map processResponseToJson(Response response) {
    var responseBody = response.body;
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonEncode(responseBody);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
      case 401:
        var responseJson = jsonEncode(responseBody);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
      case 400:
        Map responseJson = json.decode(responseBody);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 400 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 403:
        Map responseJson = json.decode(WebConstants.statusCode404Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 403 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 404:
        Map responseJson = json.decode(WebConstants.statusCode404Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 404 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 500:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 500 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 502:
        Map responseJson = json.decode(WebConstants.statusCode502Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 502 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      case 503:
        Map responseJson = json.decode(WebConstants.statusCode503Message);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 503 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseJson;
      default:
        var responseJson = jsonEncode(responseBody);
        if (AppConstants.isWebLogToPrint) {
          debugPrint("Webservices 200 decoded Response $responseJson",
              wrapWidth: 3072);
        }
        return responseBody;
    }
  }

  ///post Login
  @override
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionLogin, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      LoginResponse mLoginResponse =
          LoginResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mLoginResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post VerifyOTP
  @override
  Future<WebResponseSuccess> postVerifyOTP(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionVerifyOtp, exhibitorsListRequest);

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
      VerifyOtpResponse mVerifyOtpResponse =
          VerifyOtpResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mVerifyOtpResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post Register
  @override
  Future<WebResponseSuccess> postRegister(dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionRegister, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      RegisterResponse mRegisterResponse =
          RegisterResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mRegisterResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetUserData
  @override
  Future<WebResponseSuccess> postGetUserData(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionProfile, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode401) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      UserDetailsResponse mUserDetailsResponse =
          UserDetailsResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mUserDetailsResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post UserDetails_Update
  @override
  Future<WebResponseSuccess> postUserDetailsUpdate(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionProfileUpdate, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      UserUpdateResponse mUserUpdateResponse =
          UserUpdateResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mUserUpdateResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post Address_Insert_Update
  @override
  Future<WebResponseSuccess> postUserAddressUpdate(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionProfileAddress, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      UserUpdateAddressResponse mUserUpdateAddressResponse =
          UserUpdateAddressResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mUserUpdateAddressResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post user Delete
  @override
  Future<WebResponseSuccess> postUserDelete(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionDeleteAccount, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      UserDeleteResponse mUserDeleteResponse =
          UserDeleteResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mUserDeleteResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///Get GeneralSetting
  @override
  Future<WebResponseSuccess> getGeneralSetting() async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider
        .getWithWithoutRequest(WebConstants.actionGetGeneralSetting);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      GetGeneralSettingResponse mGetGeneralSettingResponse =
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
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetBestSellerItem, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetDashboard, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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

  ///post GetAllBranchesByRestaurantID
  @override
  Future<WebResponseSuccess> postGetAllBranchesByRestaurantID(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllBranchesByRestaurantID, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      GetAllBranchesByRestaurantIdResponse
          mGetAllBranchesByRestaurantIdResponse =
          GetAllBranchesByRestaurantIdResponse.fromJson(
              processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllBranchesByRestaurantIdResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetCategory
  @override
  Future<WebResponseSuccess> postGetCategory(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetCategory, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetCategoryResponse mGetCategoryResponse =
          GetCategoryResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetCategoryResponse,
        statusMessage: "",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode404) {
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        statusMessage: 'No Data Found',
        error: true,
      );
    } else {
      GetCategoryResponse mGetCategoryResponse =
          GetCategoryResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetCategoryResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetCategoryItem
  @override
  Future<WebResponseSuccess> postGetCategoryItem(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetCategoryItem, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
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
      GetCategoryItemResponse mGetCategoryItemResponse =
          GetCategoryItemResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetCategoryItemResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetItemDetails
  @override
  Future<WebResponseSuccess> postGetItemDetails(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetItemDetails, exhibitorsListRequest);
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
      GetItemDetailsResponse mGetItemDetailsResponse =
          GetItemDetailsResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetItemDetailsResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

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
      // GetItemDetailsResponse mGetItemDetailsResponse =
      //     GetItemDetailsResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mGetItemDetailsResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///ProfileImage
  @override
  Future<WebResponseSuccess> postProfileImageFile(String filePart,
      ProfileImageUpdateRequest mProfileImageUpdateRequest) async {
    AppAlert.showProgressDialog(Get.context!);

    WebConstants.auth = true;
    final cases = await WebHttpProvider()
        .postWithAuthAndRequestAndAttachmentProfileImage(
            WebConstants.actionSaveImage, mProfileImageUpdateRequest.toJson(),
            filePath: filePart);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      // ProfileUpdateResponse mProfileUpdateResponse =
      // ProfileUpdateResponse.fromJson(jsonDecode(cases.body.toString()));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        statusMessage: "mProfileUpdateResponse.message",
        error: true,
      );
    } else {
      // ProfileUpdateResponse mProfileUpdateResponse =
      // ProfileUpdateResponse.fromJson(jsonDecode(cases.body.toString()));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mProfileUpdateResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }
}



import 'dart:convert';

import 'package:f_b_base/data/remote/api_call/api_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../alert/app_alert_base.dart';
import '../../../../constants/web_constants.dart';
import '../../../mode/login/login_response.dart';
import '../../../mode/profile_image/profile_image_update_request.dart';
import '../../../mode/register/register_response.dart';
import '../../../mode/user_address_update/user_update_address_response.dart';
import '../../../mode/user_delete/user_delete_response.dart';
import '../../../mode/user_details/user_details_response.dart';
import '../../../mode/user_update/user_update_response.dart';
import '../../../mode/verify_otp/verify_otp_response.dart';
import '../../web_response.dart';
import '../../web_response_failed.dart';
import '../api_dio_provider.dart';
import 'user_authentication_api.dart';

class UserAuthenticationApiImpl extends AllApiImpl with UserAuthenticationApi {

  ///post Login
  @override
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest) async {
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionLogin, exhibitorsListRequest);
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
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionVerifyOtp, exhibitorsListRequest);

    AppAlertBase.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode409) {
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
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = false;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionRegister, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlertBase.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      RegisterResponse mRegisterResponse =
      RegisterResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mRegisterResponse,
        statusMessage: "",
        error: false,
      );

    } else if (cases.statusCode == WebConstants.statusCode409) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mRegisterResponse,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetUserData
  @override
  Future<WebResponseSuccess> postGetUserData(
      dynamic exhibitorsListRequest) async {
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionProfile, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlertBase.hideLoadingDialog(Get.context!);
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
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionProfileUpdate, exhibitorsListRequest);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");
    AppAlertBase.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode409) {
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
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionProfileAddress, exhibitorsListRequest);
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
    AppAlertBase.showProgressDialog(Get.context!);
    WebConstants.auth = true;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionDeleteAccount, exhibitorsListRequest);
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


  ///ProfileImage
  @override
  Future<WebResponseSuccess> postProfileImageFile(String filePart,
      ProfileImageUpdateRequest mProfileImageUpdateRequest) async {
    AppAlertBase.showProgressDialog(Get.context!);

    WebConstants.auth = true;
    final cases = await WebHttpProvider()
        .postWithAuthAndRequestAndAttachmentProfileImage(
        WebConstants.actionSaveImage, mProfileImageUpdateRequest.toJson(),
        filePath: filePart);
    debugPrint(
        "plainJsonRequest statusCode ==  ${jsonEncode(cases.statusCode)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(cases.body)}");

    AppAlertBase.hideLoadingDialog(Get.context!);
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

// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';

import '../common/button_constants.dart';
import '../common/text_input_widget.dart';
import '../constants/color_constants.dart';
import '../constants/image_assets_constants.dart';
import '../lang/translation_service_key.dart';
import '../model/location_list_screen/view/location_list_screen.dart';
import '../model/qr_code_scanner/view/qr_code_scanner_view.dart';
import 'alert_action.dart';

class AppAlert {
  AppAlert._();

  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  static showProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black38,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Center(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(18.5.sp),
                  height: 90,
                  width: 90,
                  child: const CircularProgressIndicator()),
            ),
          );
        });
  }

  static hideLoadingDialog(BuildContext context) {
    Get.back();
  }

  static Future<void> showCustomDialogYesNoLogout(
    BuildContext context,
    String title,
    String message,
    Function onCall, {
    bool? barrierDismissible,
    String? leftText,
    String? rightText,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Text(
                      title,
                      style: getText600(
                        colors: ColorConstants.cAppColorsBlue,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16.sp, right: 16.sp, bottom: 16.sp),
                    child: Text(message,
                        style: getTextRegular(
                          colors: ColorConstants.black,
                          size: 17.sp,
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  height: 26.5.sp,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  child: rectangleRoundedCornerButtonMedium(
                                      leftText ?? 'Cancel', () {
                                    Get.back();
                                  },
                                      bgColor: ColorConstants.cAppColors,
                                      size: 16.sp,
                                      textColor: Colors.white))),
                          SizedBox(
                            width: 15.sp,
                          ),
                          Expanded(
                              child: Container(
                                  height: 26.5.sp,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  child: rectangleRoundedCornerButtonMedium(
                                      rightText ?? 'Log Out', () {
                                    Get.back();
                                    onCall();
                                  },
                                      bgColor:  Colors.black54,
                                      size: 16.sp,
                                      textColor:Colors.white))),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  static Future<String> showCustomDialogPicDine(
    BuildContext context, {
    bool? barrierDismissible,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: Container(
                    width: 95.w,
                    height: 35.h,
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: ColorConstants.primaryBackgroundColor,
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.sp,
                        ),
                        Text(
                          'Select Type',
                          style: getText600(
                              colors: ColorConstants.cAppColorsBlue,
                              size: 19.5.sp),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10.sp, right: 10.sp, top: 17.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: homeDeliveryPickupView(
                                      ImageAssetsConstants.dinein,
                                      'Dine',
                                      'In')),
                              SizedBox(
                                width: 15.5.sp,
                              ),
                              Expanded(
                                  child: homeDeliveryPickupView(
                                      ImageAssetsConstants.take,
                                      'Take',
                                      'Away')),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25.sp,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 33.sp,
                            right: 33.sp,
                          ),
                          child: rectangleRoundedCornerButtonBold('CANCEL', () {
                            Get.back(result: '');
                          },
                              bgColor: ColorConstants.cAppColorsBlue,
                              textColor: Colors.white,
                              height: 28.sp,
                              size: 17.sp),
                        )
                      ],
                    )),
              )),
        );
      },
      barrierDismissible: barrierDismissible ?? false,
      useSafeArea:
          true, // Optional: Ensures the dialog doesn't overlap the status bar
    );
  }

  static Future<String> showCustomDialogLocationPicker(
    BuildContext context, {
    bool? barrierDismissible,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LocationListScreen();
      },
      barrierDismissible: barrierDismissible ?? false,
      useSafeArea:
          false, // Optional: Ensures the dialog doesn't overlap the status bar
    );
  }

  static Future<String> showQrcodeScan(
      BuildContext context, {
        bool? barrierDismissible,
      }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const QrCodeScannerView();
      },
      barrierDismissible: barrierDismissible ?? false,
      useSafeArea:
      false, // Optional: Ensures the dialog doesn't overlap the status bar
    );
  }

  static Future<void> showChangePassword(
      BuildContext context, Function onCall) async {
    ///change password
    final TextEditingController mCurrentPasswordController =
        TextEditingController();
    final TextEditingController mNewPasswordController =
        TextEditingController();
    final TextEditingController mConfirmPasswordController =
        TextEditingController();

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Builder(
              builder: (context) {
                return Container(
                  margin: EdgeInsets.all(12.sp),
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                            ),
                            Text(
                              sChangePassword.tr,
                              style: getText500(
                                  colors: Colors.black, size: 16.5.sp),
                            ),
                            SizedBox(
                              height: 7.sp,
                            ),
                            Text(
                              sChangeYourPasswordDetails.tr,
                              maxLines: 4,
                              style: getText500(
                                  colors: ColorConstants.black, size: 14.5.sp),
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sCurrentPassword.tr,
                              controller: mCurrentPasswordController,
                              errorText: null,
                              textInputType: TextInputType.emailAddress,
                              hintText: sCurrentPasswordHint.tr,
                              showFloatingLabel: true,
                              // prefixIcon: Icons.email_rounded,
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sNewPassword.tr,
                              controller: mNewPasswordController,
                              errorText: null,
                              textInputType: TextInputType.text,
                              hintText: sNewPasswordHint.tr,
                              showFloatingLabel: true,
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            TextInputWidget(
                              placeHolder: sConfirmPassword.tr,
                              controller: mConfirmPasswordController,
                              errorText: null,
                              textInputType: TextInputType.text,
                              hintText: sConfirmPasswordHint.tr,
                              showFloatingLabel: true,
                            ),
                            SizedBox(
                              height: 14.sp,
                            ),
                            Container(
                                height: 26.5.sp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                child: rectangleRoundedCornerButtonMedium(
                                    sUpdate.tr, () {
                                  String message = '';
                                  if (mCurrentPasswordController
                                      .value.text.isEmpty) {
                                    message = sCurrentPasswordHint.tr;
                                  } else if (mNewPasswordController
                                      .value.text.isEmpty) {
                                    message = sNewPasswordHint.tr;
                                  } else if (mNewPasswordController
                                          .value.text.length <
                                      6) {
                                    message = sPasswordErrorValid.tr;
                                  } else if (mConfirmPasswordController
                                      .value.text.isEmpty) {
                                    message = sConfirmPasswordHint.tr;
                                  } else if (mConfirmPasswordController
                                          .value.text.length <
                                      6) {
                                    message = sPasswordErrorValid.tr;
                                  } else if (mNewPasswordController
                                          .value.text !=
                                      mConfirmPasswordController.value.text) {
                                    message =
                                        'New password doesn\'t match with confirm password';
                                  }
                                  if (message.isEmpty) {
                                    onCall(mCurrentPasswordController.text,
                                        mNewPasswordController.text);
                                  } else {
                                    AppAlert.showSnackBar(
                                        Get.context!, message);
                                  }
                                },
                                    bgColor: ColorConstants.cAppColors,
                                    textColor: Colors.white)),
                            SizedBox(
                              height: 14.sp,
                            ),
                            Container(
                                height: 26.5.sp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.sp),
                                ),
                                child: rectangleRoundedCornerButtonMedium(
                                    'Cancel', () {
                                  Get.back();
                                },
                                    bgColor: ColorConstants.cAppColorsBlue,
                                    textColor: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  static homeDeliveryPickupView(
      String imageAsset, String title, String subTitle) {
    return GestureDetector(
      onTap: () {
        Get.back(result: title);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                width: 43.w,
                height: 32.sp,
                margin: EdgeInsets.only(top: 24.5.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11.sp),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorConstants.appEditTextHint,
                      blurRadius: 3,
                      offset: Offset(0, 0), // Shadow position
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 18.sp),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: getTextBold(
                          colors: ColorConstants.buttonBar, size: 17.5.sp),
                    ),
                    Text(
                      subTitle,
                      style: getTextRegular(
                          colors: ColorConstants.cAppColorsBlue, size: 17.sp),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  imageAsset,
                  height: 40.5.sp,
                  width: 25.w,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AlertActionWithReturnString {
  final AlertAction alertAction;
  final String reasonString;

  AlertActionWithReturnString(this.alertAction, this.reasonString);
}

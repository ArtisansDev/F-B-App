import 'dart:io';

import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/common/button_constants.dart';
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/common/text_input_widget.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/pattern_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/update_profile_controller.dart';

class UpdateProfileScreen extends GetView<UpdateProfileScreenController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UpdateProfileScreenController());
    return Scaffold(
        appBar: AppBarsCommon.appBarNoBack(title: 'Update Profile'),
        body: SafeArea(child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Opacity(
                        opacity: 0.5, // Set opacity here
                        child: Image.asset(
                        ImageAssetsConstants.buttonLogo,
                        width: 40.w,
                        fit: BoxFit.contain,
                      ),)
                    ),
                    Obx(
                      () {
                        return fullView();
                      },
                    ),
                  ],
                ))));
  }

  fullView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///profile pic
          viewProfilePic(),

          ///Personal Info
          personalInfoView(),

          ///Delivery Address (Home)
          deliveryAddressHome(),

          ///Delivery Address (Office)
          deliveryAddressOffice(),

          SizedBox(
            height: 8.h,
          )
        ],
      ),
    );
  }

  viewProfilePic() {
    return Container(
        margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 19.sp),
        child: Row(
          children: [
            Container(
              height: 19.w,
              width: 19.w,
              padding: EdgeInsets.all(controller.attachmentPath.value != null
                  ? 2.sp
                  : controller.imageUrl.value != null
                      ? 2.sp
                      : 15.sp),
              decoration: BoxDecoration(
                color: ColorConstants.appProgress,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.buttonBar.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, -2), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                child: controller.attachmentPath.value != null
                    ? ClipOval(
                        child: Image.file(
                        File(controller.attachmentPath.value ?? ''),
                        fit: BoxFit.fill,
                        height: 18.w,
                        width: 18.w,
                      ))
                    : controller.imageUrl.value != null
                        ? cacheProfileImage(controller.imageUrl.value ?? '',
                            ImageAssetsConstants.profile, 18.w)
                        : setImageSize(ImageAssetsConstants.profile,
                            fit: BoxFit.fill, size: 18.w),
              ),
            ),
            SizedBox(
              width: 30.sp,
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                controller.mImagePickerUtils.settingImagePicker();
              },
              child: Container(
                height: 19.w,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change Profile Pic',
                  style: getTextBold(
                      size: 18.sp, colors: ColorConstants.cAppColorsBlue),
                ),
              ),
            )),
          ],
        ));
  }

  personalInfoView() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 19.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              SizedBox(
                height: 6.w,
              ),
              Expanded(
                  child: Text(
                'Personal Info',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              )),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 15.sp),
            padding: EdgeInsets.all(13.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 24.5.sp,
                  child: TextInputWidget(
                    topPadding: 0.sp,
                    isReadOnly: controller.mProfile.value,
                    controller: controller.nameController.value,
                    showFloatingLabel: false,
                    placeHolder: sEnterYourName.tr,
                    hintText: sEnterYourName.tr,
                    errorText: null,
                    prefixImage: ImageAssetsConstants.edit1,
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternStringAndSpace)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: 24.5.sp,
                  child: TextInputWidget(
                    topPadding: 0.sp,
                    isReadOnly: controller.mProfile.value,
                    controller: controller.emailController.value,
                    showFloatingLabel: false,
                    placeHolder: sEmailIdHint.tr,
                    hintText: sEmailIdHint.tr,
                    errorText: null,
                    prefixImage: ImageAssetsConstants.edit2,
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternEmailStringAtDot)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: 24.5.sp,
                  child: TextInputWidget(
                    topPadding: 0.sp,
                    isReadOnly: true,
                    controller: controller.mobileNumberController.value,
                    showFloatingLabel: false,
                    placeHolder: sEnterMobileNumber.tr,
                    hintText: sEnterMobileNumber.tr,
                    errorText: null,
                    prefixImage: ImageAssetsConstants.edit3,
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternStringAndSpace)),
                    ],
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 15.sp,
        ),
        Container(
          margin: EdgeInsets.only(right: 19.sp),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 25.w,
            child: rectangleRoundedCornerButtonBold(
                controller.mProfile.value ? 'Edit' : 'Save', () {
              if (!controller.mProfile.value) {
                ///save
                controller.isProfileUpdate();
              } else {
                controller.mProfile.value = !controller.mProfile.value;
              }
            },
                bgColor: controller.mProfile.value
                    ? ColorConstants.buttonBar
                    : ColorConstants.cAppColorsBlue,
                textColor: Colors.white,
                height: 26.sp,
                size: 16.sp),
          ),
        ),
      ],
    );
  }

  deliveryAddressHome() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 19.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              SizedBox(
                height: 6.w,
              ),
              Text(
                'Delivery Address',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
              Text(
                ' (Home)',
                style:
                    getText600(colors: ColorConstants.buttonBar, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 15.sp),
            padding: EdgeInsets.all(13.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.5.sp,
                  child: setImage(ImageAssetsConstants.edit4,
                      fit: BoxFit.fitHeight),
                ),
                Expanded(
                    child: TextInputWidget(
                  isReadOnly: controller.mAddress1.value,
                  controller: controller.addressController1.value,
                  minLines: 5,
                  maxLines: 50,
                  topPadding: 13.sp,
                  showFloatingLabel: false,
                  placeHolder: sDeliveryAddress1.tr,
                  hintText: sDeliveryAddress1.tr,
                  errorText: null,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                        RegExp(AppUtilConstants.patternAddress)),
                  ],
                ))
              ],
            )),
        SizedBox(
          height: 15.sp,
        ),
        Container(
          margin: EdgeInsets.only(right: 19.sp),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 25.w,
            child: rectangleRoundedCornerButtonBold(
                controller.mAddress1.value ? 'Edit' : 'Save', () {
              if (!controller.mAddress1.value) {
                ///save
                controller.isUpdateAddress("0");
              } else {
                controller.mAddress1.value = !controller.mAddress1.value;
              }
            },
                bgColor: controller.mAddress1.value
                    ? ColorConstants.buttonBar
                    : ColorConstants.cAppColorsBlue,
                textColor: Colors.white,
                height: 26.sp,
                size: 16.sp),
          ),
        ),
      ],
    );
  }

  deliveryAddressOffice() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 19.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              SizedBox(
                height: 6.w,
              ),
              Text(
                'Delivery Address',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
              Text(
                ' (Office)',
                style:
                    getText600(colors: ColorConstants.buttonBar, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 15.sp),
            padding: EdgeInsets.all(13.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.5.sp,
                  child: setImage(ImageAssetsConstants.edit5,
                      fit: BoxFit.fitHeight),
                ),
                Expanded(
                    child: TextInputWidget(
                  isReadOnly: controller.mAddress2.value,
                  controller: controller.addressController2.value,
                  minLines: 5,
                  maxLines: 50,
                  topPadding: 13.sp,
                  showFloatingLabel: false,
                  placeHolder: sDeliveryAddress2.tr,
                  hintText: sDeliveryAddress2.tr,
                  errorText: null,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                        RegExp(AppUtilConstants.patternAddress)),
                  ],
                ))
              ],
            )),
        SizedBox(
          height: 15.sp,
        ),
        Container(
          margin: EdgeInsets.only(right: 19.sp),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 25.w,
            child: rectangleRoundedCornerButtonBold(
                controller.mAddress2.value ? 'Edit' : 'Save', () {
              if (!controller.mAddress2.value) {
                ///save
                controller.isUpdateAddress("1");
              } else {
                controller.mAddress2.value = !controller.mAddress2.value;
              }
            },
                bgColor: controller.mAddress2.value
                    ? ColorConstants.buttonBar
                    : ColorConstants.cAppColorsBlue,
                textColor: Colors.white,
                height: 26.sp,
                size: 16.sp),
          ),
        ),
      ],
    );
  }
}

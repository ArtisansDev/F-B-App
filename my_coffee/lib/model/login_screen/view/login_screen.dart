import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import '../../../common/appbars_common.dart';
import '../../../common/button_constants.dart';
import '../../../common/text_input_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/pattern_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/app_utils.dart';
import '../../otp_screen/controller/otp_controller.dart';
import '../../register_screen/controller/register_screen_controller.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginScreenController());
    return Scaffold(
        appBar: AppBarsCommon.appBarBack(title: sLoginOrSignUp.tr),
        body: SafeArea(bottom: false, child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          if (Get.isRegistered<OtpScreenController>()) {
            Get.delete<OtpScreenController>();
          }
          if (Get.isRegistered<RegisterScreenController>()) {
            Get.delete<RegisterScreenController>();
          }
        },
        onVisibilityLost: () {},
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorConstants.primaryBackgroundColor,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        ImageAssetsConstants.buttonLogo,
                        width: 40.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    mLoginView(),
                  ],
                ))));
  }

  mLoginView() {
    return Obx(
      () {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 18.sp,
              ),
              Container(
                height: 20.sp,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  ImageAssetsConstants.appLogo,
                  width: 25.w,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 20.sp,
              ),

              ///Enter mobile number
              Container(
                height: 27.5.sp,
                margin: EdgeInsets.only(
                    left: 28.sp, right: 28.sp, bottom: 16.5.sp, top: 15.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.22),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ], // use instead of BorderRadius.all(Radius.circular(20))
                ),
                child: TextInputWidget(
                  controller: controller.mobileNumberController.value,
                  showFloatingLabel: false,
                  isPhone: true,
                  sPrefixText: controller.phoneCode.value,
                  placeHolder: sEnterMobileNumber.tr,
                  onClick: (value) {
                    if (value == 'prefixIcon') {
                      showCountryPicker(
                        context: Get.context!,
                        countryListTheme: CountryListThemeData(
                          backgroundColor: Colors.white,
                          textStyle: getText500(
                              colors: ColorConstants.black, size: 16.sp),
                          bottomSheetHeight: 69.h,
                          // Optional. Country list modal height
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11.sp),
                            topRight: Radius.circular(11.sp),
                          ),
                        ),
                        showPhoneCode: true,
                        // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          controller.phoneCode.value = country.phoneCode;
                        },
                      );
                    }
                  },
                  hintText: sEnterMobileNumber.tr,
                  errorText: null,
                  prefixHeight: 27.5.sp,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(AppUtilConstants.patternOnlyNumber),
                    ),
                    LengthLimitingTextInputFormatter(10)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Receive code Via',
                  style: getTextRegular(size: 15.sp, colors: Colors.grey),
                ),
              ),
              SizedBox(
                height: 16.5.sp,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 28.sp,
                  right: 28.sp,
                ),
                child: rectangleRoundedCornerButtonBold('Whats App', () {
                  controller.isLogin('wp');
                },
                    bgColor: ColorConstants.yourKeySkillsColor1,
                    textColor: Colors.white,
                    height: 28.sp,
                    mIconData: ImageAssetsConstants.loginWp,
                    mIconSize: 20.sp,
                    size: 17.sp),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 28.sp,
                  right: 28.sp,
                ),
                child: rectangleRoundedCornerButtonBold('SMS', () {
                  controller.isLogin('sms');
                },
                    bgColor: ColorConstants.cAppColorsBlue,
                    textColor: Colors.white,
                    height: 28.sp,
                    mIconData: ImageAssetsConstants.loginSms,
                    size: 17.sp),
              ),
              // By Logging in or registering, you agree to our Terms of Service, Privacy Policy and  Personal Data Protection Policy
              Container(
                  margin: EdgeInsets.only(
                      left: 28.sp, right: 28.sp, top: 20.sp, bottom: 20.sp),
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By Logging in or registering, you agree to our\n',
                      style: getTextRegularNoHeights(
                          size: 15.sp, colors: ColorConstants.buttonBar),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Terms of Service, Privacy Policy ',
                            style: getTextRegularNoHeights(
                                size: 15.sp,
                                colors: ColorConstants.cAppColorsBlue)),
                        const TextSpan(text: 'and\n'),
                        TextSpan(
                            text: 'Personal Data Protection Policy',
                            style: getTextRegularNoHeights(
                                size: 15.sp,
                                colors: ColorConstants.cAppColorsBlue)),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

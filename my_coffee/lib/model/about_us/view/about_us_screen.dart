import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';

import '../../../../common/appbars_common.dart';
import '../../../../common/button_constants.dart';
import '../../../../common/custom_image.dart';
import '../../../../common/text_input_widget.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/pattern_constants.dart';
import '../../../../lang/translation_service_key.dart';
import '../../../../routes/route_constants.dart';
import '../../../../utils/app_utils.dart';
import '../controller/about_us_controller.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AboutUsController());
    return Scaffold(
        appBar: AppBarsCommon.appBarNoBack(title: 'About Us'),
        body: SafeArea(child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          controller.getAboutUs();
        },
        onVisibilityLost: () {
          Get.delete<AboutUsController>();
        },
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
                      child: Image.asset(
                        ImageAssetsConstants.buttonLogo,
                        width: 40.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Obx(
                      () {
                        return Container(
                          margin: EdgeInsets.all(18.sp),
                          height: double.infinity,
                          width: double.infinity,
                          child:
                              controller.mGetGeneralSettingData.value.aboutUs ==
                                      null
                                  ? const Center(
                                      child: Text("Loading..."),
                                    )
                                  : Visibility(
                                      visible: controller.mGetGeneralSettingData
                                              .value.aboutUs !=
                                          null,
                                      child: SingleChildScrollView(
                                        child: HtmlWidget(
                                          controller.mGetGeneralSettingData
                                                  .value.aboutUs ??
                                              '',
                                          // // textAlign: TextAlign.center,
                                          // // maxLines: 2,,
                                          // textStyle: getText500(
                                          //     size: 15.sp,
                                          //     colors: ColorConstants.buttonBar,
                                          //     heights: 1.3),
                                        ),
                                      )),
                        );
                      },
                    )
                  ],
                ))));
  }
}

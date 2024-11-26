import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

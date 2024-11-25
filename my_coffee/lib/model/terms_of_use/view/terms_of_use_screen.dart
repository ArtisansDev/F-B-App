import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/terms_of_use_controller.dart';

class TermsOfUseScreen extends GetView<TermsOfUseController> {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TermsOfUseController());
    return Scaffold(
        appBar: AppBarsCommon.appBarNoBack(title: 'Terms Of Use'),
        body: SafeArea(child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          controller.getTermsOfUse();
        },
        onVisibilityLost: () {
          Get.delete<TermsOfUseController>();
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
                                              .value.termsAndCondition !=
                                          null,
                                      child: SingleChildScrollView(
                                        child: HtmlWidget(
                                          controller.mGetGeneralSettingData
                                                  .value.termsAndCondition ??
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

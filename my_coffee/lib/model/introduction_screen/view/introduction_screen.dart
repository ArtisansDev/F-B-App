import 'package:f_b_base/common/button_constants.dart';
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controller/introduction_controller.dart';

class IntroductionScreen extends GetView<IntroductionScreenController> {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => IntroductionScreenController());
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: _fullView(),
          bottom: false,
        ));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          /// Get the full current URL
          String url = Uri.base.toString();
          controller.seatID.value ="";
          /// http://localhost:54052/#/introduction_screen?table_no=10&BranchIDF=d8254b69-b6e0-4f10-9d61-888a5d2f779e
          if (url.contains('localhost')) {
              if (url.split(':').length > 2) {
                url = url.split(':').first + '://' + url.split(':').last;
            }
          }

          if (url.contains('SeatID')) {
            url = url.replaceAll('#', 'abcd');
            final uri = Uri.parse(url);
            controller.seatID.value = uri.queryParameters['SeatID'].toString();
          }

        },
        onVisibilityLost: () {
          if (Get.isRegistered<IntroductionScreenController>()) {
            Get.delete<IntroductionScreenController>();
          }
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
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
                      ),
                    )),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                          child: PageView.builder(
                        controller: controller.introductionPageController,
                        itemCount: 1, // Number of pages
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(35.sp),
                            child: setImage(
                                ImageAssetsConstants.appLogo),
                          );
                        },
                        onPageChanged: (value) {
                          controller.onChangePage(value);
                        },
                      )),
                      bottomView()
                    ],
                  ),
                )
              ],
            )));
  }

  bottomView() {
    return Container(
      margin: EdgeInsets.all(15.5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: controller.introductionPageController,
              count: 1,
              effect: WormEffect(
                dotHeight: 13.sp,
                dotWidth: 13.sp,
                activeDotColor: ColorConstants.cAppColorsBlue,
                dotColor: ColorConstants.appProgress,
              ),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.sp, right: 20.sp, bottom: 20.sp),
            child: rectangleRoundedCornerButtonMedium(sButtonText.tr, () {
              controller.goToNextPage();
            },
                bgColor: ColorConstants.cAppColorsBlue,
                textColor: Colors.white,
                height: 28.sp,
                size: 17.sp),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../common/appbars_common.dart';
import '../../../common/button_constants.dart';
import '../../../common/custom_image.dart';
import '../../../common/text_input_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/app_utils.dart';
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
        onVisibilityGained: () {},
        onVisibilityLost: () {
          Get.delete<IntroductionScreenController>();
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  // child: Image.asset(
                  //   ImageAssetsConstants.buttonLogo,
                  //   width: 40.w,
                  //   fit: BoxFit.contain,
                  // ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                          child: PageView.builder(
                        controller: controller.introductionPageController,
                        itemCount: 2, // Number of pages
                        itemBuilder: (context, index) {
                          return setImage(index == 0
                              ? ImageAssetsConstants.introductionImage3
                              : ImageAssetsConstants.introductionImage4);
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
              count: 2,
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

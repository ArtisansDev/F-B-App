// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/model/home_screen/view/top_address_bar/top_address_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../common/custom_image.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../utils/app_utils.dart';
import '../../menu_screen/top_address_bar/top_address_bar.dart';
import '../../order_now/order_now.dart';
import '../controller/home_controller.dart';
import 'best_sellers/best_selles_screen.dart';
import 'button_advertisement/button_advertisement_screen.dart';
import 'dine_pickup_view/dine_pickup_screen.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeScreenController());
    return _fullView();
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          controller.bFocusGained.value = true;
          controller.detDashboardDetailsApi();
          controller.getOrderDetails();
        },
        onVisibilityLost: () {
          if (Get.isRegistered<HomeScreenController>()) {
            controller.bFocusGained.value = false;
          }
          //Get.delete<HomeScreenController>();
        },
        child: GestureDetector(
          onTap: () {
            AppUtils.hideKeyboard(Get.context!);
          },
          child: RefreshIndicator(
              onRefresh: () async {
                controller.onRefresh();
              },
              child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: mHomeView())),
        ));
  }

  mHomeView() {
    return Obx(() {
      return Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TopAddressBar
              TopHomeAddressBar(),

              ///Banner list
              Stack(
                children: [
                  SizedBox(
                      height: 100.w * 0.5,
                      child: PageView.builder(
                        controller: controller.introductionPageController.value,
                        itemCount: controller.mBannerMaster.value.length,
                        itemBuilder: (context, index) {
                          return cacheImageHomeBanner(
                            controller.mBannerMaster.value[index]
                                    .bannerImagePath ??
                                '',
                            ImageAssetsConstants.backLogo,
                            100.w * 0.5,
                          );
                        },
                        onPageChanged: (value) {
                          controller.onChangePage(value);
                        },
                      )),
                  Visibility(
                      visible: controller.mBannerMaster.value.isNotEmpty,
                      child: Container(
                        height: 100.w * 0.5,
                        padding: EdgeInsets.only(bottom: 15.sp),
                        alignment: Alignment.bottomCenter,
                        child: SmoothPageIndicator(
                          controller:
                              controller.introductionPageController.value,
                          count: controller.mBannerMaster.value.length,
                          effect: WormEffect(
                            dotHeight: 13.sp,
                            dotWidth: 13.sp,
                            activeDotColor: ColorConstants.cAppColorsBlue,
                            dotColor: ColorConstants.appProgress,
                          ),
                        ),
                      )),
                ],
              ),

              ///DinePickup
              DinePickupScreen(),

              // ///Advertisement coffee
              // Container(
              //   margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 17.sp),
              //   decoration: BoxDecoration(
              //       color: ColorConstants.primaryBackgroundColor,
              //       borderRadius: BorderRadius.circular(11.sp),
              //       boxShadow: const [
              //         BoxShadow(
              //             color: Color(0x33000000),
              //             offset: Offset(0, 2),
              //             blurRadius: 4),
              //       ]),
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(11.sp),
              //       child: setImageBanner(ImageAssetsConstants.bannerImage1)),
              // ),

              ///hot sale
              BestSellersScreen(),

              // ///ButtonAdvertisement
              // ButtonAdvertisementScreen(),

              // show view
              // Container(
              //   margin: EdgeInsets.only(
              //       right: 28.sp, left: 28.sp, top: 20.sp, bottom: 18.sp),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             'TWT ',
              //             style: getText600(
              //                 colors: ColorConstants.buttonBar, size: 20.sp),
              //           ),
              //           Text('Balance',
              //               style: getTextPraise500(
              //                   colors: ColorConstants.cAppColorsBlue,
              //                   size: 20.sp)),
              //           Expanded(child: Container()),
              //           SizedBox(
              //             width: 20.w,
              //             child: rectangleCornerButton('50 RM', () {},
              //                 bgColor: ColorConstants.cAppColorsBlue,
              //                 textColor: Colors.white,
              //                 height: 25.sp,
              //                 size: 16.5.sp),
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 18.sp,
              //       ),
              //       Row(
              //         children: [
              //           Text(
              //             'TWT ',
              //             style: getText600(
              //                 colors: ColorConstants.buttonBar, size: 20.sp),
              //           ),
              //           Text('Rewards',
              //               style: getTextPraise500(
              //                   colors: ColorConstants.cAppColorsBlue,
              //                   size: 20.sp)),
              //           Expanded(child: Container()),
              //           SizedBox(
              //             width: 25.w,
              //             child: rectangleCornerButton('500 Pts', () {},
              //                 bgColor: ColorConstants.cAppColorsBlue,
              //                 textColor: Colors.white,
              //                 height: 25.sp,
              //                 size: 16.5.sp),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // const ShoppingScreen(),

              SizedBox(
                height: (controller.mAddCartModel.value.mItems ?? []).isNotEmpty
                    ? 18.h
                    : 9.h,
              )
            ],
          )),
          Container(
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Visibility(
                  visible:
                      (controller.mAddCartModel.value.mItems ?? []).isNotEmpty,
                  child: OrderNow((controller.mAddCartModel.value))))
        ],
      );
    });
  }
}

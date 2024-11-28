/*
 * Project      : my_coffee
 * File         : dashboard_navigation.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/dashboard_controller.dart';

class DashboardNavigationScreen extends StatelessWidget {
  late DashboardScreenController controller;

  DashboardNavigationScreen({super.key}) {
    controller = Get.find<DashboardScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _bottomNavigationBar();
    });
  }

  _bottomNavigationBar() {
    return Container(
        height: 9.h,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
        decoration: BoxDecoration(
          color: ColorConstants.buttonBar.withOpacity(0.80),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, -2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(11.sp),
            topLeft: Radius.circular(11.sp),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: bottomBarRowView(controller.selectedIndex.value, 0,
                    ImageAssetsConstants.iconMenu1, sHome.tr,
                    imageAsset: ImageAssetsConstants.buttonLogo)),
            Expanded(
                child: bottomBarRowView(controller.selectedIndex.value, 1,
                    ImageAssetsConstants.iconMenu2, sMenu.tr)),
            Expanded(
                child: bottomBarRowView(controller.selectedIndex.value, 2,
                    ImageAssetsConstants.iconMenu3, sHistory.tr)),
            // Expanded(
            //     child: bottomBarRowView(controller.selectedIndex.value, 3,
            //         ImageAssetsConstants.iconMenu4, sRewards.tr)),
            Expanded(
                child: bottomBarRowView(controller.selectedIndex.value, 3,
                    ImageAssetsConstants.iconMenu5, sProfile.tr))
          ],
        ));
  }

  bottomBarRowView(int selectValue, int position, String image, String title,
      {String? imageAsset}) {
    return GestureDetector(
        onTap: () {
          controller.onItemTapped(position);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageAsset == null
                ? svgImageSet(image, 23.sp, 23.sp,
                    colour: selectValue == position
                        ? ColorConstants.cAppColorsBlue
                        : Colors.white)
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      selectValue == position
                          ? ColorConstants.cAppColorsBlue
                          : Colors.white, // The color you want to apply
                      BlendMode.srcATop, // Blend mode to apply the color
                    ),
                    child: Image.asset(
                      imageAsset,
                      width: 23.sp,
                      fit: BoxFit.fitWidth,
                    )),
            SizedBox(
              height: 9.sp,
            ),
            Text(
              title,
              style: getText600(
                  colors: selectValue == position
                      ? ColorConstants.cAppColorsBlue
                      : Colors.white,
                  size: 14.5.sp),
            )
          ],
        ));
  }
}

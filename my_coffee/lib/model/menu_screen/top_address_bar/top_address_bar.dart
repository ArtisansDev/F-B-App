/*
 * Project      : my_coffee
 * File         : top_address_bar.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-25
 * Version      : 1.0
 * Ticket       : 
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/custom_image.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../controller/menu_controller.dart';

class TopAddressBar extends StatelessWidget {
  late MenuScreenController controller;

  TopAddressBar({super.key}) {
    controller = Get.find<MenuScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(18.sp),
          padding: EdgeInsets.only(left: 18.sp, right: 6.sp),
          width: double.infinity,
          height: 27.sp,
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
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    controller.changeLocation();
                  },
                  child: SizedBox(
                    child: setImage(ImageAssetsConstants.homeLocation),
                    height: 20.sp,
                    width: 20.sp,
                  )),
              SizedBox(
                width: 15.sp,
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      controller.changeLocation();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        controller
                                .mDashboardScreenController
                                .selectGetAllBranchesListData
                                .value
                                .branchName ??
                            '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getText500(
                            colors: ColorConstants.buttonBar, size: 16.sp),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  // controller.val.value = !controller.val.value;
                },
                child: Container(
                    width: 19.w,
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorConstants.buttonBar.withOpacity(0.80)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: controller.mDashboardScreenController
                                    .sDialogPicDine.value ==
                                'Dine',
                            child: Container(
                              width: 18.w,
                              height: 25.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorConstants.cAppColorsBlue),
                              child: Center(
                                  child: Text('DINE - IN',
                                      style: getText500(
                                          size: 14.5.sp,
                                          colors: Colors.white))),
                            )),
                        Visibility(
                            visible: controller.mDashboardScreenController
                                    .sDialogPicDine.value ==
                                'Take',
                            child: Container(
                              width: 18.w,
                              height: 25.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorConstants.cAppColorsBlue),
                              child: Center(
                                  child: Text(
                                'PICKUP',
                                style: getText500(
                                    size: 14.5.sp, colors: Colors.white),
                              )),
                            )),
                      ],
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}

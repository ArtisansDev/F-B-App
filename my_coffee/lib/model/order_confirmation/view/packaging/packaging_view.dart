// ignore_for_file: must_be_immutable

/*
 * Project      : my_coffee
 * File         : middle_filter_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-25
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:my_coffee/common/custom_image.dart';
import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/image_assets_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/order_confirmation_controller.dart';

class PackagingView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  PackagingView({super.key}) {
    controller = Get.find<OrderConfirmationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Packaging',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 12.sp,
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 5.h,
                      child: setImage(ImageAssetsConstants.needStraws),
                    ),
                    SizedBox(
                      width: 13.sp,
                    ),
                    Expanded(
                        child: Text(
                          'I need Straws',
                          style: getText500(
                              size: 16.sp, colors: ColorConstants.buttonBar),
                        )),
                    const Icon(
                      Icons.check_box_rounded,
                      color: ColorConstants.cAppColorsBlue,
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 12.sp,
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 5.h,
                      child: setImage(ImageAssetsConstants.bag),
                    ),
                    SizedBox(
                      width: 13.sp,
                    ),
                    Expanded(
                        child: Text(
                          'I need Paper Bag for my order',
                          style: getText500(
                              size: 16.sp, colors: ColorConstants.buttonBar),
                        )),
                    Icon(
                      Icons.check_box_outline_blank_rounded,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

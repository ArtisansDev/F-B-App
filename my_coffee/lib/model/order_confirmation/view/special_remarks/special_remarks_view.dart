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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/custom_image.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../../../utils/open_url.dart';
import '../../controller/order_confirmation_controller.dart';

class SpecialRemarksView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  SpecialRemarksView({super.key}) {
    controller = Get.find<OrderConfirmationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Special Remarks',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
            padding: EdgeInsets.only(
                left: 11.sp, right: 11.sp, top: 14.sp, bottom: 14.sp),
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
                      height: 4.h,
                      width: 4.h,
                      child: setImage(ImageAssetsConstants.remarks),
                    ),
                    SizedBox(
                      width: 13.sp,
                    ),
                    Expanded(
                        child: Text(
                      'Let us know if you have any special requests. E.g. I need sugar sachet.',
                      style: getTextRegular(
                          size: 15.5.sp,
                          colors: ColorConstants.appVersion,
                          heights: 1.2),
                    )),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

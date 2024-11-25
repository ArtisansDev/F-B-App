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

import 'package:f_b_base/common/button_constants.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/order_confirmation_controller.dart';

class BottomBarOrderNowView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  BottomBarOrderNowView({super.key}) {
    controller = Get.find<OrderConfirmationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          height: 11.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
          decoration: BoxDecoration(
            color: ColorConstants.buttonBar.withOpacity(0.80),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.buttonBar.withOpacity(0.05),
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
          child: Container(
            margin: EdgeInsets.all(18.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Items  ${controller.totalCountItem.value}',
                      style: getText500(colors: Colors.white, size: 15.sp),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      '${controller.mDashboardScreenController.selectedCurrency.value} ${getDoubleValue(controller.totalAmount.value).toStringAsFixed(2)}',
                      style: getText600(
                          colors: ColorConstants.cAppColorsBlue, size: 17.sp),
                    ),
                  ],
                ),
                Container(
                  width: 45.w,
                  margin: EdgeInsets.only(left: 20.sp),
                  child: rectangleRoundedCornerButtonMedium(sOrderNow.tr, () {
                    controller.orderNow();
                  },
                      bgColor: ColorConstants.cAppColorsBlue,
                      textColor: Colors.white,
                      height: 28.sp,
                      size: 17.sp),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

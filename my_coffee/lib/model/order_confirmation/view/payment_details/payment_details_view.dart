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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/custom_image.dart';
import '../../../../common/text_input_widget.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/pattern_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../../../utils/open_url.dart';
import '../../controller/order_confirmation_controller.dart';

class PaymentDetailsView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  PaymentDetailsView({super.key}) {
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
                'Payment Details',
                style: getTextBold(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount (Incl. 6% SST)',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 9.90',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Voucher',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 0.0',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: getText600(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 9.90',
                    style: getText600(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Delivery fee',
              //       style: getTextRegular(
              //           size: 14.5.sp,
              //           colors: ColorConstants.buttonBar,
              //           heights: 1.3),
              //     ),
              //     Text(
              //       'RM 0.00',
              //       style: getTextRegular(
              //           size: 14.5.sp,
              //           colors: ColorConstants.buttonBar,
              //           heights: 1.3),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 10.sp,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rounding Adj',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 0.00',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

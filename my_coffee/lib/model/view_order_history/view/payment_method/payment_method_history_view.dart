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

import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/view_order_history_controller.dart';

class PaymentMethodHistoryView extends StatelessWidget {
  late ViewOrderHistoryController controller;

  PaymentMethodHistoryView({super.key}) {
    controller = Get.find<ViewOrderHistoryController>();
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
                'Payment Method',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 17.sp, right: 17.sp, top: 17.sp),
            padding: EdgeInsets.only(
                left: 14.sp, right: 14.sp, top: 18.sp, bottom: 18.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.paymentTypeList.value.length,
              itemBuilder: (context, index) {
                return GestureDetector(onTap: () {
                  controller.paymentTypeSelect(index);
                }, child: Obx(() {
                  return Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              index == 0
                                  ? ImageAssetsConstants.paypal
                                  : ImageAssetsConstants.internet,
                              width: 23.sp,
                              height: 23.sp,
                            ),
                            SizedBox(
                              width: 13.sp,
                            ),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      index == 0
                                          ? 'Pay with PayPal (All International Card)'
                                          : 'Net Banking',
                                      style: getText600(
                                          size: 14.7.sp,
                                          colors: ColorConstants.buttonBar),
                                    ),
                                    SizedBox(
                                      height: 8.sp,
                                    ),
                                    Text(
                                      index == 0
                                          ? '(Paypal - All international Card accepted)'
                                          : 'Netbanking / UPI / Domestic Cards only',
                                      style: getTextRegular(
                                          size: 14.sp,
                                          colors: ColorConstants.buttonBar),
                                    )
                                  ],
                                )),
                            SizedBox(
                              width: 13.sp,
                            ),
                            Icon(
                              controller.paymentType.value == index
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: ColorConstants.cAppColorsBlue,
                            )
                          ],
                        ),
                        Visibility(
                          visible: index == 0,
                          child: Container(
                            width: double.infinity,
                            height: 3.sp,
                            margin: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                            color: ColorConstants.appEditTextHint,
                          ),
                        )
                      ],
                    ),
                  );
                }));
              },
            )

            // Row(
            //   children: [
            //     SizedBox(
            //       height: 5.h,
            //       width: 5.h,
            //       child: setImage(ImageAssetsConstants.addVoucher),
            //     ),
            //     SizedBox(
            //       width: 13.sp,
            //     ),
            //     Expanded(
            //         child: Text(
            //           'Select Payment Method',
            //           style:
            //           getText500(size: 16.sp, colors: ColorConstants.buttonBar),
            //         )),
            //   ],
            // ),
            ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 21.sp, right: 19.sp, top: 13.sp),
          child: Text(
            'Enjoy Faster checkout by paying with TWT Balance!',
            style: getTextRegular(
                size: 14.5.sp, colors: ColorConstants.buttonBar, heights: 1.3),
          ),
        ),
      ],
    );
  }
}

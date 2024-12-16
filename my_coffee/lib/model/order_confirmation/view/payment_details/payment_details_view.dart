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
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/order_confirmation_controller.dart';

class PaymentDetailsView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  PaymentDetailsView({super.key}) {
    controller = Get.find<OrderConfirmationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
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
              padding: EdgeInsets.only(
                  left: 18.sp, right: 18.sp, top: 18.sp, bottom: 18.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13.sp),
              ),
              child: Column(
                children: [
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (controller
                                  .selectGetAllBranchesListData.value.taxData ??
                              [])
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        TaxData mTaxData = (controller
                                .selectGetAllBranchesListData.value.taxData ??
                            [])[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${mTaxData.taxName} (${mTaxData.taxPercentage}%)',
                                  style: getTextRegular(
                                      size: 14.5.sp,
                                      colors: ColorConstants.buttonBar,
                                      heights: 1.3),
                                ),
                                Text(
                                  '${controller.mDashboardScreenController.selectedCurrency.value} ${getDoubleValue(calculatePercentageOf(controller.subTotalAmount.value, mTaxData.taxPercentage ?? 0)).toStringAsFixed(2)}',
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
                          ],
                        );
                      }),
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
                        'RM 0.00',
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
                  Visibility(
                      visible: (controller
                                  .selectGetAllBranchesListData.value.taxData ??
                              [])
                          .isNotEmpty,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Tax',
                                style: getText600(
                                    size: 14.5.sp,
                                    colors: ColorConstants.buttonBar,
                                    heights: 1.3),
                              ),
                              Text(
                                '${controller.mDashboardScreenController.selectedCurrency.value} ${getDoubleValue(controller.totalTaxAmount.value).toStringAsFixed(2)}',
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
                        ],
                      )),
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
                        '${controller.mDashboardScreenController.selectedCurrency.value} ${getDoubleValue(controller.subTotalAmount.value).toStringAsFixed(2)}',
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
      },
    );
  }
}

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

import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/mode/get_general_setting/get_general_setting_response.dart';
import 'package:f_b_base/data/mode/payment_type/payment_type_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/order_confirmation_controller.dart';

class PaymentMethodView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  PaymentMethodView({super.key}) {
    controller = Get.find<OrderConfirmationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Visibility(
            visible: controller.paymentTypeList.value.isNotEmpty,
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
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
                    margin:
                        EdgeInsets.only(left: 17.sp, right: 17.sp, top: 17.sp),
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
                        PaymentTypeResponseData mPaymentTypeResponseData =
                            controller.paymentTypeList[index];
                        return GestureDetector(onTap: () {
                          controller.paymentTypeSelect(index);
                        }, child: Obx(() {
                          return Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ///image
                                    (mPaymentTypeResponseData
                                                    .paymentGatewayLogo ??
                                                '')
                                            .isEmpty
                                        ? Container(
                                            height: 9.h,
                                            alignment: Alignment.topCenter,
                                            child: Image.asset(
                                              ImageAssetsConstants.internet,
                                              width: 23.sp,
                                              height: 23.sp,
                                            ),
                                          )
                                        : Container(
                                            width: 23.sp,
                                            height: 23.sp,
                                            alignment: Alignment.bottomCenter,
                                            child: cacheBestItemImage(
                                              mPaymentTypeResponseData
                                                      .paymentGatewayLogo ??
                                                  '',
                                              ImageAssetsConstants.internet,
                                              23.sp,
                                            )),
                                    SizedBox(
                                      width: 13.sp,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mPaymentTypeResponseData
                                                  .paymentGatewayName ??
                                              '',
                                          style: getText600(
                                              size: 14.7.sp,
                                              colors: ColorConstants.buttonBar),
                                        ),
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        Text(
                                          mPaymentTypeResponseData
                                                  .description ??
                                              '',
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
                                  visible: index != controller.paymentTypeList.value.length-1,
                                  child: Container(
                                    width: double.infinity,
                                    height: 3.sp,
                                    margin: EdgeInsets.only(
                                        top: 15.sp, bottom: 15.sp),
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
                  margin:
                      EdgeInsets.only(left: 21.sp, right: 19.sp, top: 13.sp),
                  child: Text(
                    'Enjoy Faster checkout by paying with ${sAppName.tr} Balance!',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

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
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/mode/payment_type/payment_type_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/history_controller.dart';

class PaymentHistoryMethodView extends StatelessWidget {
  late HistoryScreenController controller;

  PaymentHistoryMethodView({super.key}) {
    controller = Get.find<HistoryScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          margin: EdgeInsets.all(18.sp),
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.sp),
          ),
          child: Visibility(
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
                              colors: ColorConstants.cAppColorsBlue,
                              size: 17.sp),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              left: 17.sp, right: 17.sp, top: 17.sp),
                          padding: EdgeInsets.only(
                              left: 14.sp,
                              right: 14.sp,
                              top: 18.sp,
                              bottom: 18.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13.sp),
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
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
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Image.asset(
                                                    ImageAssetsConstants
                                                        .internet,
                                                    width: 23.sp,
                                                    height: 23.sp,
                                                  ),
                                                )
                                              : Container(
                                                  width: 23.sp,
                                                  height: 23.sp,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: cacheBestItemImage(
                                                    mPaymentTypeResponseData
                                                            .paymentGatewayLogo ??
                                                        '',
                                                    ImageAssetsConstants
                                                        .internet,
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
                                                    colors: ColorConstants
                                                        .buttonBar),
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
                                                    colors: ColorConstants
                                                        .buttonBar),
                                              )
                                            ],
                                          )),
                                          SizedBox(
                                            width: 13.sp,
                                          ),
                                          Icon(
                                            controller.paymentType.value ==
                                                    index
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_off,
                                            color:
                                                ColorConstants.cAppColorsBlue,
                                          )
                                        ],
                                      ),
                                      Visibility(
                                        visible: index == 0,
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
                          ))),
                  Container(
                    width: 45.w,
                    margin: EdgeInsets.only(top: 10.sp, bottom: 15.sp),
                    child: rectangleRoundedCornerButtonMedium('Done', () {
                      Get.back();
                    },
                        bgColor: ColorConstants.cAppColorsBlue,
                        textColor: Colors.white,
                        height: 26.sp,
                        size: 15.5.sp),
                  ),
                ],
              )),
        );
      },
    );
  }
}

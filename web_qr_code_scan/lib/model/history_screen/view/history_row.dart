import 'package:f_b_base/common/button_constants.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/mode/get_order_history/order_history_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/utils/date_format.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/history_controller.dart';

class HistoryRow extends StatelessWidget {
  final int index;
  late HistoryScreenController controller;
  late OrderHistoryResponseItemData mOrderHistoryResponse;

  HistoryRow({super.key, required this.index}) {
    controller = Get.find<HistoryScreenController>();
    mOrderHistoryResponse =
        controller.mOrderHistoryResponseItemData.value[index];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.gotOrderHistoryDetails(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 15.sp),
        padding: EdgeInsets.all(14.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///branch
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mOrderHistoryResponse.branchName ?? '',
                            maxLines: 2,
                            style: getText600(
                                size: 15.5.sp,
                                colors: ColorConstants.cAppColorsBlue)),
                        // Text('city, State -70075',
                        //     maxLines: 2,
                        //     style: getTextRegular(
                        //         size: 14.sp,
                        //         colors: ColorConstants.appVersion))
                      ],
                    )),
                SizedBox(
                  width: 15.sp,
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              getUTCToLocalDateTime(
                                  mOrderHistoryResponse.orderDate ?? ''),
                              maxLines: 1,
                              style: getText500(
                                  size: 14.2.sp,
                                  colors: ColorConstants.appVersion)),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                              (mOrderHistoryResponse.orderType ?? 1) == 1
                                  ? 'Dine In'
                                  : 'Take Away',
                              maxLines: 1,
                              style: getText600(
                                  size: 15.5.sp,
                                  colors: ColorConstants.textColour)),
                        ]))
              ],
            ),

            ///top line
            Container(
              height: 2.5.sp,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
              color: ColorConstants.appVersion,
            ),

            ///Order Id
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order ID',
                            maxLines: 1,
                            style: getText600(
                                size: 15.5.sp,
                                colors: ColorConstants.black)),
                        SizedBox(height: 5.sp,),
                        Text('${
                          controller.mGetGeneralSettingData.value?.orderIDPrefixCode ?? ''
                        }${mOrderHistoryResponse.trackingOrderID ?? ''}' ,
                            maxLines: 1,
                            style: getText500(
                                size: 15.5.sp,
                                colors: ColorConstants.cAppColorsBlue)),

                      ],
                    )),
                SizedBox(
                  width: 15.sp,
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Payment status',
                            maxLines: 1,
                            style: getText600(
                                size: 15.5.sp,
                                colors: ColorConstants.black)),
                        SizedBox(height: 5.sp,),
                        Text(
                            (mOrderHistoryResponse.paymentStatus ?? '')=='P'?'Pending':
                            (mOrderHistoryResponse.paymentStatus ?? '')=='S'?'Success':
                            (mOrderHistoryResponse.paymentStatus ?? '')=='C'?'Cancel':'Waiting'
                            ,
                            maxLines: 1,
                            style: getText500(
                                size: 15.5.sp,
                                colors: ColorConstants.cAppColorsBlue)),

                      ],
                    ))
              ],
            ),
            Container(
              height: 2.5.sp,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
              color: ColorConstants.appVersion,
            ),

            ///Item
            Column(
              children: (mOrderHistoryResponse.orderMenu ?? []).map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.itemName ?? '',
                                  maxLines: 1,
                                  style: getText600(
                                      size: 16.sp,
                                      colors: ColorConstants.buttonBar)),
                              Text(item.itemVariantName ?? '',
                                  maxLines: 1,
                                  style: getTextRegular(
                                      size: 14.sp,
                                      colors: ColorConstants.buttonBar))
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('X${item.quantity}',
                                style: getText600(
                                    size: 15.sp,
                                    colors: ColorConstants.buttonBar)),
                          )),
                      Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                '${mOrderHistoryResponse.currencySymbol} ${getDoubleValue((item.totalItemAmount ?? 1) / (item.quantity ?? 1)).toStringAsFixed(2)}',
                                style: getText600(
                                    size: 15.sp,
                                    colors: ColorConstants.cAppColorsBlue)),
                          ))
                    ],
                  ),
                );
              }).toList(),
            ),

            ///end line
            Container(
              height: 2.5.sp,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
              color: ColorConstants.appVersion,
            ),

            ///Packaging name
            Visibility(
                visible: (mOrderHistoryResponse.packagingName ?? '').isNotEmpty,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Packaging Type : '),
                        Expanded(
                            child: Text(
                                (mOrderHistoryResponse.packagingName ?? ''),
                                style: getText500(
                                    size: 15.5.sp,
                                    colors: ColorConstants.buttonBar)))
                      ],
                    ),
                    Container(
                      height: 2.5.sp,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                      color: ColorConstants.appVersion,
                    )
                  ],
                )),

            ///reorder
            Row(
              children: [
                (mOrderHistoryResponse.paymentStatus == 'P' ||
                            mOrderHistoryResponse.paymentStatus == 'F') &&
                        ((mOrderHistoryResponse.paymentGatewayNo ?? 0)
                                .toString() !=
                            '0')
                    ? Container(
                        width: 45.w,
                        margin: EdgeInsets.only(top: 10.sp),
                        child: rectangleRoundedCornerButtonMedium('Pay Now',
                            () {
                          controller.selectPayment(mOrderHistoryResponse);
                          // controller.payNow(mOrderHistoryResponse);
                        },
                            bgColor: ColorConstants.cAppColorsBlue,
                            textColor: Colors.white,
                            height: 26.sp,
                            size: 15.5.sp),
                      )
                    : Container(
                        width: 45.w,
                        margin: EdgeInsets.only(top: 10.sp),
                        child: rectangleRoundedCornerButtonMedium(sReorder.tr,
                            () {
                          controller.gotOrderHistoryDetails(index);
                        },
                            bgColor: ColorConstants.cAppColorsBlue,
                            textColor: Colors.white,
                            height: 26.sp,
                            size: 15.5.sp),
                      ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            (mOrderHistoryResponse.adjustedAmount ?? 0.0) > 0
                                ? '${mOrderHistoryResponse.currencySymbol} ${(mOrderHistoryResponse.adjustedAmount ?? 0.0).toStringAsFixed(2)}'
                                : '${mOrderHistoryResponse.currencySymbol} ${(mOrderHistoryResponse.totalAmount ?? 0.0).toStringAsFixed(2)}',
                            style: getText600(
                                size: 17.sp,
                                colors: ColorConstants.cAppColorsBlue)))
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

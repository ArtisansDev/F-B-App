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
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/custom_image.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../../../data/mode/get_item_details/get_item_details_response.dart';
import '../../../../utils/open_url.dart';
import '../../controller/order_confirmation_controller.dart';

class OrderListView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  OrderListView({super.key}) {
    controller = Get.find<OrderConfirmationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Visibility(
            visible: (controller.mItems.value ?? []).isNotEmpty,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 19.sp, right: 19.sp, top: 18.sp, bottom: 10.sp),
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      Text(
                        'Your Order ${(controller.mItems.value ?? []).length}',
                        style: getText600(
                            colors: ColorConstants.cAppColorsBlue, size: 17.sp),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (controller.mItems.value ?? []).length,
                  itemBuilder: (BuildContext context, int index) {
                    GetItemDetailsData mGetItemDetailsData =
                        controller.mItems.value[index];
                    return Container(
                        height: 14.5.h,
                        margin: EdgeInsets.only(
                            left: 18.sp, right: 18.sp, top: 15.sp),
                        padding: EdgeInsets.all(14.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13.sp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///image
                            (mGetItemDetailsData.itemImages ?? []).isEmpty
                                ? Container(
                                    height: 9.h,
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      ImageAssetsConstants.backLogo,
                                      fit: BoxFit.fitHeight,
                                      height: 8.5.h,
                                    ),
                                  )
                                : Container(
                                    height: 9.h,
                                    alignment: Alignment.bottomCenter,
                                    child: cacheBestItemImage(
                                        (mGetItemDetailsData.itemImages ?? [])
                                                .first
                                                .itemImagePath ??
                                            '',
                                        ImageAssetsConstants.backLogo,
                                        9.h)),
                            SizedBox(
                              width: 12.sp,
                            ),

                            ///details
                            Expanded(
                                child: Container(
                              height: 11.8.h,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mGetItemDetailsData.itemName ?? '',
                                    maxLines: 2,
                                    style: getText600(
                                        size: 16.sp,
                                        colors: ColorConstants.buttonBar,
                                        heights: 1.2),
                                  ),
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  Text(
                                    'RM ${mGetItemDetailsData.perItemTotal}',
                                    style: getText600(
                                      size: 15.5.sp,
                                      colors: ColorConstants.cAppColorsBlue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  (mGetItemDetailsData.description ?? '')
                                          .contains('<')
                                      ? HtmlWidget(
                                          mGetItemDetailsData.description ?? '',
                                          textStyle: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 15.sp,
                                            color: ColorConstants.appVersion,
                                          ))
                                      : Text(
                                          mGetItemDetailsData.description ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: getTextRegular(
                                            size: 15.sp,
                                            colors: ColorConstants.appVersion,
                                          ),
                                        )
                                ],
                              ),
                            )),
                            SizedBox(
                              width: 12.sp,
                            ),

                            ///delete and edit
                            Container(
                                margin: EdgeInsets.only(top: 11.sp),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    incDecView(mGetItemDetailsData, index),
                                    SizedBox(
                                      width: 22.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 24.sp,
                                            width: 24.sp,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        11.sp),
                                                color:
                                                    ColorConstants.buttonBar),
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: Image.asset(
                                                ImageAssetsConstants.editOrder,
                                                fit: BoxFit.fitHeight,
                                                height: 20.sp,
                                              ),
                                              onPressed: () {
                                                controller.editOrder(index);
                                              },
                                              color: ColorConstants.buttonBar,
                                              iconSize: 17.sp,
                                            ),
                                          ),
                                          Container(
                                              height: 24.sp,
                                              width: 24.sp,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11.sp),
                                                  color: ColorConstants
                                                      .cAppColorsBlue),
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Image.asset(
                                                    ImageAssetsConstants
                                                        .deleteOrder,
                                                    fit: BoxFit.fitHeight,
                                                    height: 20.sp,
                                                  ),
                                                  onPressed: () {
                                                    controller
                                                        .deleteOrder(index);
                                                  },
                                                  color:
                                                      ColorConstants.buttonBar,
                                                  iconSize: 17.sp,
                                                ),
                                                onPressed: () {
                                                  controller.priceIncDec(
                                                      mGetItemDetailsData,
                                                      index,
                                                      (mGetItemDetailsData
                                                                  .count ??
                                                              0) +
                                                          1);
                                                },
                                                color: Colors.white,
                                                iconSize: 17.sp,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ));
                  },
                )
              ],
            ));
      },
    );
  }

  incDecView(GetItemDetailsData mGetItemDetailsData, int index) {
    return Container(
        height: 22.sp,
        width: 22.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.sp), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Decrement button
            Container(
              height: 22.sp,
              width: 22.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.sp),
                  color: Colors.grey.shade300),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if ((mGetItemDetailsData.count ?? 0) > 1) {
                    controller.priceIncDec(mGetItemDetailsData, index,
                        (mGetItemDetailsData.count ?? 0) - 1);
                  }
                },
                color: ColorConstants.buttonBar,
                iconSize: 17.sp,
              ),
            ),

            // Counter display
            Text(
              '${(mGetItemDetailsData.count ?? 0)}',
              style: getText500(colors: ColorConstants.buttonBar, size: 15.sp),
            ),

            // Increment button
            Container(
                height: 22.sp,
                width: 22.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.sp),
                    color: ColorConstants.cAppColorsBlue),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    controller.priceIncDec(mGetItemDetailsData, index,
                        (mGetItemDetailsData.count ?? 0) + 1);
                  },
                  color: Colors.white,
                  iconSize: 17.sp,
                )),
          ],
        ));
  }
}

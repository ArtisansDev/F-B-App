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
import '../../../../utils/date_format.dart';
import '../../../../utils/open_url.dart';
import '../../controller/view_order_history_controller.dart';

class PickUpAtHistoryView extends StatelessWidget {
  late ViewOrderHistoryController controller;

  PickUpAtHistoryView({super.key}) {
    controller = Get.find<ViewOrderHistoryController>();
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
                    'Store Details',
                    style: getText600(
                        colors: ColorConstants.cAppColorsBlue, size: 17.sp),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 17.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageAssetsConstants.take,
                      width: 23.w,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              ImageAssetsConstants.shopName,
                              height: 22.sp,
                              width: 22.sp,
                            ),
                            SizedBox(
                              width: 11.sp,
                            ),
                            Expanded(
                                child: Text(
                              controller.selectGetAllBranchesListData.value
                                      .branchName ??
                                  '',
                              maxLines: 2,
                              style: getText600(
                                  size: 17.sp,
                                  colors: ColorConstants.buttonBar,
                                  heights: 1.2),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        GestureDetector(
                            onTap: () {
                              openGoogleMapsAddress(controller
                                      .selectGetAllBranchesListData
                                      .value
                                      .address ??
                                  '');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 21.sp,
                                  width: 21.sp,
                                  child: setImage(
                                      ImageAssetsConstants.homeLocationPin),
                                ),
                                SizedBox(
                                  width: 11.sp,
                                ),
                                Expanded(
                                  child: Text(
                                      controller.selectGetAllBranchesListData
                                              .value.address ??
                                          '',
                                      style: getTextRegular(
                                          size: 16.sp,
                                          colors: ColorConstants.buttonBar)),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 5.sp,
                        ),
                        GestureDetector(
                            onTap: () {
                              openLaunchUrlWp(controller
                                      .selectGetAllBranchesListData
                                      .value
                                      .mobileNumber ??
                                  '');
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 21.sp,
                                  width: 21.sp,
                                  child: setImage(ImageAssetsConstants.edit3),
                                ),
                                SizedBox(
                                  width: 11.sp,
                                ),
                                Expanded(
                                  child: Text(
                                      controller.selectGetAllBranchesListData
                                              .value.mobileNumber ??
                                          '',
                                      style: getTextRegular(
                                          size: 16.sp,
                                          colors: ColorConstants.buttonBar)),
                                )
                              ],
                            )),
                      ],
                    ))
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 17.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15.sp,
                        ),
                        Text(
                          'Order Type : ',
                          style: getTextRegular(
                              size: 17.sp,
                              colors: ColorConstants.buttonBar,
                              heights: 1.2),
                        ),
                        Text(
                          (controller
                              .mAddCartModel
                              .value
                              .mOrderHistoryResponseItemData
                              ?.orderType ?? 1) == 1 ? 'Dine In'
                              : 'Take Away',
                          style: getText600(
                              size: 17.sp,
                              colors: ColorConstants.textColour,
                              heights: 1.2),
                        ),
                        // Text(
                        //   '(Edit)',
                        //   style: getTextRegular(
                        //       size: 17.sp,
                        //       colors: ColorConstants.cAppColorsBlue,
                        //       heights: 1.2),
                        // )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        //controller.selectDateAndTime();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: 18.sp, bottom: 18.sp, top: 15.sp),
                        padding: EdgeInsets.only(left: 18.sp, right: 9.sp),
                        width: double.infinity,
                        height: 28.sp,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.22),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: ColorConstants.cAppColors,
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 15.sp,
                            ),
                            Expanded(
                                child: Text(
                              controller.selectedDateTime.value == null
                                  ? 'Select Schedule'
                                  : getDateMMYYYYTime(
                                      controller.selectedDateTime.value ??
                                          DateTime.now()),
                              style: getText500(
                                  colors: ColorConstants.buttonBar,
                                  size: 16.sp),
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        );
      },
    );
  }
}

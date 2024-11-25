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
import 'package:f_b_base/common/text_input_widget.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/pattern_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 12.sp,
                ),
                SizedBox(
                  height: 4.h,
                  width: 4.h,
                  child: setImage(ImageAssetsConstants.remarks,
                      fit: BoxFit.fitHeight),
                ),
                SizedBox(
                  width: 13.sp,
                ),
                Expanded(child: TextInputWidget(
                  isReadOnly: false,
                  controller: controller.remarksController.value,
                  minLines: 5,
                  maxLines: 30,
                  showFloatingLabel: false,
                  placeHolder: null,
                  hintText: 'Let us know if you have any special requests. E.g. I need sugar sachet.',
                  errorText: null,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                        RegExp(AppUtilConstants.patternSkills)),
                  ],
                ))
              ],
            )),
      ],
    );
  }
}

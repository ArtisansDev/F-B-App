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

import '../../../constants/color_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../controller/menu_controller.dart';

class MiddleFilterView extends StatelessWidget {
  late MenuScreenController controller;

  MiddleFilterView({super.key}) {
    controller = Get.find<MenuScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 18.sp, bottom: 18.sp),
              padding: EdgeInsets.only(left: 17.sp, right: 9.sp),
              width: double.infinity,
              height: 26.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.22),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shopify_rounded,
                    color: ColorConstants.cAppColors,
                    size: 20.sp,
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  Expanded(
                      child: Text(
                        'Open as Usual',
                        style: getTextBold(
                            colors: ColorConstants.yourKeySkillsColor1, size: 15.sp),
                      )),
                ],
              ),
            )),
        SizedBox(
          width: 18.sp,
        ),
        Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 18.sp, bottom: 18.sp),
              padding: EdgeInsets.only(left: 18.sp, right: 9.sp),
              width: double.infinity,
              height: 26.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.22),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 0), // changes position of shadow
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
                        'Select Schedule',
                        style:
                        getText500(colors: ColorConstants.buttonBar, size: 14.sp),
                      )),
                ],
              ),
            ))
      ],
    );
  }
}
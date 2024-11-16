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
import '../../../../constants/color_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../controller/view_order_history_controller.dart';
import 'frequently_item_history_row.dart';

class FrequentlyEnjoyedWithHistoryView extends StatelessWidget {
  late ViewOrderHistoryController controller;

  FrequentlyEnjoyedWithHistoryView({super.key}) {
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
                'Frequently Enjoyed With',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 13.sp),
            height: 15.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return FrequentlyItemHistoryRow(
                  index: index,
                );
              },
            ))
      ],
    );
  }
}

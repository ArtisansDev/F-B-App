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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/custom_image.dart';
import '../../../../common/text_input_widget.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/pattern_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../../../utils/open_url.dart';
import '../../controller/order_confirmation_controller.dart';

class AddVouchersView extends StatelessWidget {
  late OrderConfirmationScreenController controller;

  AddVouchersView({super.key}) {
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
                'Vouchers',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.sp),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 5.h,
                width: 5.h,
                child: setImage(ImageAssetsConstants.addVoucher),
              ),
              SizedBox(
                width: 13.sp,
              ),
              Expanded(
                  child: Text(
                    'Add Voucher',
                    style:
                    getText500(size: 16.sp, colors: ColorConstants.buttonBar),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

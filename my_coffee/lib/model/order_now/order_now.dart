/*
 * Project      : my_coffee
 * File         : order_now.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-31
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:my_coffee/common/button_constants.dart';
import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:my_coffee/data/mode/add_cart/add_cart.dart';
import 'package:my_coffee/lang/translation_service_key.dart';
import 'package:my_coffee/utils/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../routes/route_constants.dart';

class OrderNow extends StatelessWidget {
  final AddCartModel mAddCartModel;

  const OrderNow(this.mAddCartModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 9.h,
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Amount',
                    style: getTextRegular(size: 15.sp, colors: Colors.grey),
                  ),
                  Text(
                    '${mAddCartModel.mGetAllBranchesListData?.currency?.first.currencySymbol ?? ''} ${getDoubleValue(mAddCartModel.totalAmount).toStringAsFixed(2)}',
                    style: getText600(
                        size: 19.5.sp, colors: ColorConstants.cAppColorsBlue),
                  )
                ],
              )),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 30.w,
                    child: rectangleRoundedCornerButtonMedium(sOrderNow.tr, () {
                      Get.toNamed(RouteConstants.rOrderConfirmationScreen);
                    },
                        bgColor: ColorConstants.cAppColorsBlue,
                        textColor: Colors.white,
                        height: 26.sp,
                        size: 16.5.sp),
                  ),
                  Container(
                    width: 30.w,
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(15.sp),
                      decoration: const BoxDecoration(
                        color: ColorConstants.buttonBar,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        (mAddCartModel.mItems ?? []).length.toString(),
                        style:
                            getTextRegular(size: 15.sp, colors: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 9.h,
        )
      ],
    );
  }
}

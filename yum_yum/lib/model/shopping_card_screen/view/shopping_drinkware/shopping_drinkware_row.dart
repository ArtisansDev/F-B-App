import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/create_card_view.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../controller/shoping_screen_controller.dart';

class ShoppingDrinkwareRow extends StatelessWidget {
  final int index;
  late ShoppingScreenController controller;

  ShoppingDrinkwareRow({super.key, required this.index}) {
    controller = Get.find<ShoppingScreenController>();
    controller.mShoppingDrinkwareListCount.value = Random().nextInt(11) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return _fullRowView();
  }

  ///full_View
  _fullRowView() {
    return getCardView(
        Container(
          height: 36.h,
          margin: EdgeInsets.all(8.sp),
          child: Center(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 15.8.h,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      ImageAssetsConstants.backLogo,
                      fit: BoxFit.fitHeight,
                      height: 14.h,
                    ),
                  ),
                  Container(
                      height: 15.8.h,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        ImageAssetsConstants.coffee,
                        fit: BoxFit.fitHeight,
                        height: 15.3.h,
                      )),
                ],
              ),
              Container(
                height: 4.h,
                margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                alignment: Alignment.center,
                child: Text(
                  'CHAM IT UP',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: getTextRegular(
                      size: 14.sp, colors: ColorConstants.cAppColorsBlue),
                ),
              ),
              Container(
                height: 4.32.h,
                margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                alignment: Alignment.topCenter,
                child: Text(
                  'White Peach Oolong Cham Latte',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: getText600(
                      size: 15.sp, colors: ColorConstants.black, heights: 1.3),
                ),
              ),
              Container(
                height: 4.h,
                margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                alignment: Alignment.center,
                child: Text(
                  '12.00 RM',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: getText500(size: 16.sp, colors: ColorConstants.black),
                ),
              ),
            ],
          )),
        ));
  }
}

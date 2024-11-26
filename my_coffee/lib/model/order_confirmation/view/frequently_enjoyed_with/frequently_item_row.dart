import 'package:f_b_base/common/button_constants.dart';
import 'package:f_b_base/common/create_card_view.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/order_confirmation_controller.dart';

class FrequentlyItemRow extends StatelessWidget {
  final int index;
  late OrderConfirmationScreenController controller;

  FrequentlyItemRow({super.key, required this.index}) {
    controller = Get.find<OrderConfirmationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return _fullRowView();
  }

  ///full_View
  _fullRowView() {
    return GestureDetector(
      onTap: () {},
      child: getCardView(
          margin: 10.sp,
          paddingTopBottom: 0.sp,
          SizedBox(
            height: 15.h,
            width: 58.w,
            child: Center(
                child: Row(
              children: [
                SizedBox(
                  height: 10.h,
                  child: Image.asset(
                    ImageAssetsConstants.frequently,
                    fit: BoxFit.fitHeight,
                    height: 10.h,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12.sp, right: 12.sp),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Chocolate Donuts',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: getTextBold(
                            size: 16.sp,
                            colors: ColorConstants.black,
                            heights: 1.3),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12.sp, right: 12.sp),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '+ RM 3.30 ',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: getText600(
                            size: 16.sp, colors: ColorConstants.cAppColorsBlue),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12.sp, right: 12.sp),
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 15.w,
                        child: rectangleRoundedCornerButtonMedium(sAddOn.tr, () {},
                            bgColor: ColorConstants.cAppColorsBlue,
                            textColor: Colors.white,
                            height: 20.sp,
                            size: 15.sp),
                      ),
                    ),
                  ],
                ))
              ],
            )),
          )),
    );
  }
}

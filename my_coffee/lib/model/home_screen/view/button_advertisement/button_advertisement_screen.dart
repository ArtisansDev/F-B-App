import 'package:f_b_base/common/create_card_view.dart';
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/home_controller.dart';

class ButtonAdvertisementScreen extends StatelessWidget {
  late HomeScreenController controller;

  ButtonAdvertisementScreen({super.key}) {
    controller = Get.find<HomeScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: 18.sp, right: 18.sp, top: 20.sp, bottom: 20.sp),
        width: double.infinity,
        height: 10.h,
        child: getCardView(
            margin: 0.sp,
            paddingTopBottom: 0.sp,
            Row(
              children: [
                setImage(ImageAssetsConstants.homeHomeGift),
                SizedBox(
                  width: 18.sp,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '50% OFF on Gift Card',
                      style: getText500(
                          colors: ColorConstants.cAppColorsBlue, size: 18.sp),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Text(
                      'Refer to your Friend',
                      style: getText600(
                          colors: ColorConstants.buttonBar, size: 15.sp),
                    )
                  ],
                ))
              ],
            )));
  }
}

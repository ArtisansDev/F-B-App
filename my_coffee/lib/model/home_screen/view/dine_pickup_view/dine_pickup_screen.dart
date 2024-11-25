import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/image_assets_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/home_controller.dart';

class DinePickupScreen extends StatelessWidget {

  late HomeScreenController controller;
  DinePickupScreen({super.key}) {
    controller = Get.find<HomeScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return  ///Dine and Take
      Container(
        margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 17.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: homeDeliveryPickupView(
                    ImageAssetsConstants.dinein, 'Dine', 'In')),
            SizedBox(
              width: 15.5.sp,
            ),
            Expanded(
                child: homeDeliveryPickupView(
                    ImageAssetsConstants.take, 'Take', 'Away')),
          ],
        ),
      );
  }

  ///home Delivery and pickup view
  homeDeliveryPickupView(String imageAsset, String title, String subTitle) {
    return GestureDetector(
      onTap: () {
        controller.showDialogPicDine(title);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                width: 43.w,
                height: 32.sp,
                margin: EdgeInsets.only(top: 24.5.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11.sp),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorConstants.appEditTextHint,
                      blurRadius: 3,
                      offset: Offset(0, 0), // Shadow position
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 18.sp),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: getTextBold(
                          colors: ColorConstants.buttonBar, size: 17.5.sp),
                    ),
                    Text(
                      subTitle,
                      style: getTextRegular(
                          colors: ColorConstants.cAppColorsBlue, size: 17.sp),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  imageAsset,
                  height: 40.5.sp,
                  width: 25.w,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

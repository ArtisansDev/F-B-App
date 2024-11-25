import 'package:my_coffee/common/custom_image.dart';
import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/image_assets_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/home_controller.dart';
import 'best_item_row.dart';

class BestSellersScreen extends StatelessWidget {
  late HomeScreenController controller;

  BestSellersScreen({super.key}) {
    controller = Get.find<HomeScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Visibility(
            visible: controller.dataGetBestSellerItemData.value.isNotEmpty,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 18.sp, right: 18.sp, top: 20.sp, bottom: 15.sp),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 21.sp,
                        width: 21.sp,
                        child: setImage(ImageAssetsConstants.homeBastSale,
                            fit: BoxFit.fill),
                      ),
                      SizedBox(
                        width: 15.sp,
                      ),
                      Text(
                        'Best Sellers',
                        style: getTextRegular(
                            size: 16.5.sp, colors: ColorConstants.buttonBar),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: 18.sp, right: 20.sp),
                    height: 30.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.dataGetBestSellerItemData.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BestItemRow(
                          index: index,
                        );
                      },
                    ))
              ],
            ));
      },
    );
  }
}

import 'package:f_b_base/alert/app_alert.dart';
import 'package:f_b_base/common/create_card_view.dart';
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_best_seller_item/get_best_seller_item_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../alert/app_alert.dart';
import '../../../location_list_screen/controller/location_list_controller.dart';
import '../../controller/home_controller.dart';

class BestItemRow extends StatelessWidget {
  final int index;
  late HomeScreenController controller;

  BestItemRow({super.key, required this.index}) {
    controller = Get.find<HomeScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    GetBestSellerItemData mGetBestSellerItemData =
        controller.dataGetBestSellerItemData.value[index];
    return GestureDetector(
      onTap: () async {
        if ((controller.mDashboardScreenController.selectGetAllBranchesListData
                    .value.branchName ??
                '')
            .isEmpty) {
          AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
          if ((mAddCartModel.mItems ?? []).isNotEmpty) {
            AppAlertBase.showCustomDialogYesNoLogout(
                Get.context!,
                'Proceed to Change?',
                'This action will clear the items in your current basket. Do you want to proceed?',
                () async {
              await SharedPrefs().setAddCartData('');
              var value =
                  await AppAlert.showCustomDialogLocationPicker(Get.context!);
              Get.delete<LocationListScreenController>();
              if (value.isNotEmpty) {
                await SharedPrefs().setAddCartData('');
                controller.selectItem(index);
              }
            }, rightText: 'Ok');
          } else {
            var value =
                await AppAlert.showCustomDialogLocationPicker(Get.context!);
            Get.delete<LocationListScreenController>();
            if (value.isNotEmpty) {
              controller.selectItem(index);
            }
          }
        } else {
          controller.selectItem(index);
        }
      },
      child: getCardView(
          margin: 10.sp,
          paddingTopBottom: 0.sp,
          Container(
            margin: EdgeInsets.only(top: 15.sp),
            width: 36.w,
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
                        child: cacheBestItemImage(
                            mGetBestSellerItemData.itemImagePath ?? '',
                            ImageAssetsConstants.backLogo,
                            15.8.h)
                        ),
                  ],
                ),
                Container(
                  height: 4.32.h,
                  margin:
                      EdgeInsets.only(left: 15.sp, right: 15.sp, top: 13.sp),
                  alignment: Alignment.center,
                  child: Text(
                    mGetBestSellerItemData.itemName ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: getText600(
                        size: 15.5.sp,
                        colors: ColorConstants.cAppColorsBlue,
                        heights: 1.3),
                  ),
                ),
                Visibility(
                    visible: controller.mDashboardScreenController
                        .selectedCurrency.value.isNotEmpty,
                    child: Container(
                      height: 4.3.h,
                      margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      alignment: Alignment.center,
                      child: Text(
                        '${controller.mDashboardScreenController.selectedCurrency.value} ${mGetBestSellerItemData.price ?? ''}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: getText500(
                            size: 15.sp, colors: ColorConstants.black),
                      ),
                    )),
              ],
            )),
          )),
    );
  }
}

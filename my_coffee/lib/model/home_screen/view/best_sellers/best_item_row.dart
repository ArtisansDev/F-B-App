import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../alert/app_alert.dart';
import '../../../../common/create_card_view.dart';
import '../../../../common/custom_image.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../../data/mode/add_cart/add_cart.dart';
import '../../../../data/mode/get_best_seller_item/get_best_seller_item_response.dart';
import '../../../dashboard_screen/controller/dashboard_controller.dart';
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
            AppAlert.showCustomDialogYesNoLogout(
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

                        // Image.asset(
                        //   index % 5 == 0
                        //       ? ImageAssetsConstants.coffee
                        //       : index % 5 == 1
                        //           ? ImageAssetsConstants.beakFast1
                        //           : index % 5 == 2
                        //               ? ImageAssetsConstants.beakFast2
                        //               : index % 5 == 3
                        //                   ? ImageAssetsConstants.beakFast3
                        //                   : ImageAssetsConstants.beakFast4,
                        //   fit: BoxFit.fitHeight,
                        //   height: 15.3.h,
                        // )
                        ),
                  ],
                ),
                // Container(
                //   height: 4.h,
                //   margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                //   alignment: Alignment.center,
                //   child: Text(
                //     mGetBestSellerItemData.itemName??'',
                //     textAlign: TextAlign.center,
                //     maxLines: 2,
                //     style: getText500(
                //         size: 14.5.sp, colors: ColorConstants.cAppColorsBlue),
                //   ),
                // ),
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
                Container(
                  height: 4.3.h,
                  margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                  alignment: Alignment.center,
                  child: Text(
                    '${mGetBestSellerItemData.price ?? ''} RM',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:
                        getText500(size: 15.sp, colors: ColorConstants.black),
                  ),
                ),
              ],
            )),
          )),
    );
  }
}

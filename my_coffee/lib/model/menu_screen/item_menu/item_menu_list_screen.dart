import 'package:f_b_base/common/create_card_view.dart';
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/common/smart_footer.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/mode/get_category/get_category_response.dart';
import 'package:f_b_base/data/mode/get_category_item/get_category_item_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/menu_controller.dart';

class ItemMenuListScreen extends StatelessWidget {
  late MenuScreenController controller;

  ItemMenuListScreen({super.key}) {
    controller = Get.find<MenuScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    GetCategoryListData mGetCategoryListData =
        controller.mGetCategoryListData.value[controller.selectSideMenu.value];
    return Obx(
      () {
        return Column(
          children: [
            // setImageBanner(ImageAssetsConstants.bannerMenu1),
            // SizedBox(
            //   height: 15.sp,
            // ),
            Row(
              children: [
                SizedBox(width: 15.sp),
                Container(
                  width: 1.w,
                  height: 2.5.h,
                  color: ColorConstants.cAppColorsBlue,
                ),
                SizedBox(width: 11.sp),
                Text(
                  mGetCategoryListData.categoryName ?? '',
                  style: getTextBold(
                      size: 16.5.sp, colors: ColorConstants.cAppColorsBlue),
                )
              ],
            ),
            SizedBox(
              height: 13.sp,
            ),
            Expanded(
                child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: controller.enablePullUp.value,
              header: const WaterDropHeader(),
              footer: getCustomFooter(),
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoadMore,
              child: controller.mGetCategoryItemListData.value.isEmpty
                  ? Center(
                      child: Text(controller.mGetCategoryItemMessage.value),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 30.h,
                      ),
                      itemCount: controller.mGetCategoryItemListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        GetCategoryItemListData mGetCategoryItemListData =
                            controller.mGetCategoryItemListData[index];
                        return GestureDetector(
                            onTap: () {
                              controller.selectItem(index);
                            },
                            child: getCardView(
                                margin: 10.sp,
                                paddingTopBottom: 0.sp,
                                Container(
                                  margin: EdgeInsets.only(top: 15.sp),
                                  height: 32.5.h,
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Visibility(
                                              visible: (mGetCategoryItemListData
                                                          .itemImages ??
                                                      [])
                                                  .isNotEmpty,
                                              child: cacheBestItemImage(
                                                  (mGetCategoryItemListData
                                                                  .itemImages ??
                                                              [])
                                                          .first
                                                          .itemImagePath ??
                                                      '',
                                                  ImageAssetsConstants.backLogo,
                                                  15.8.h))

                                        ],
                                      ),
                                      Container(
                                        height: 4.32.h,
                                        margin: EdgeInsets.only(
                                            top: 10.sp,
                                            bottom: 10.sp,
                                            left: 10.sp,
                                            right: 10.sp),
                                        alignment: Alignment.center,
                                        child: Text(
                                          mGetCategoryItemListData.itemName ??
                                              '',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: getText600(
                                              size: 15.sp,
                                              colors:
                                                  ColorConstants.cAppColorsBlue,
                                              heights: 1.3),
                                        ),
                                      ),
                                      Container(
                                        height: 4.h,
                                        margin: EdgeInsets.only(
                                            left: 8.sp, right: 8.sp),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${controller.mDashboardScreenController
                                              .selectedCurrency.value} ${mGetCategoryItemListData.price ?? ''}',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: getText500(
                                              size: 15.sp,
                                              colors: ColorConstants.black),
                                        ),
                                      ),
                                    ],
                                  )),
                                )));
                      },
                    ),
            ))
          ],
        );
      },
    );

    // return ScrollablePositionedList.builder(
    //       itemScrollController: controller.itemScrollController.value,
    //       scrollOffsetController: controller.scrollOffsetController.value,
    //       itemPositionsListener: controller.itemPositionsListener.value,
    //       scrollOffsetListener: controller.scrollOffsetListener.value,
    //       itemCount: 1,
    //       //controller.itemCount.value,
    //       itemBuilder: (BuildContext context, int index) {
    //         return ItemMenuRow(index: index);
    //       },
    //     );
  }
}

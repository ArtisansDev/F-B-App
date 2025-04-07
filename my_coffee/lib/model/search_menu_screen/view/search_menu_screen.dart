import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/common/create_card_view.dart';
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/common/smart_footer.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/mode/get_category_item/get_category_item_response.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/model/search_menu_screen/view/search_item_list_search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/search_menu_screen_controller.dart';

class SearchMenuScreen extends GetView<SearchMenuScreenController> {
  const SearchMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SearchMenuScreenController());
    return Scaffold(
        appBar: AppBarsCommon.appBarNoBack(title: 'Search Menu'),
        body: SafeArea(bottom: false, child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: Opacity(
                      opacity: 0.5, // Set opacity here
                      child: Image.asset(
                        ImageAssetsConstants.buttonLogo,
                        width: 40.w,
                        fit: BoxFit.contain,
                      ),
                    )),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: detailsView(),
                )
              ],
            )));
  }

  detailsView() {
    return Obx(
      () {
        return Container(
          margin: EdgeInsets.all(15.5.sp),
          child: Column(
            children: [
              SearchItemListSearch(),
              Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: controller.enablePullUp.value,
                      header: const WaterDropHeader(),
                      footer: getCustomFooter(),
                      controller: controller.refreshController,
                      onRefresh: controller.onRefresh,
                      onLoading: controller.onLoadMore,
                      child: controller.mGetCategoryItemMessage.value.isNotEmpty
                          ? Center(
                              child: Text(
                                  controller.mGetCategoryItemMessage.value),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 30.h,
                              ),
                              itemCount:
                                  controller.mGetCategoryItemListData.length,
                              itemBuilder: (BuildContext context, int index) {
                                GetCategoryItemListData
                                    mGetCategoryItemListData =
                                    controller.mGetCategoryItemListData[index];
                                return GestureDetector(
                                    onTap: () {
                                      if (!(mGetCategoryItemListData
                                              .isStockOut ??
                                          false)) {
                                        controller.selectItem(index);
                                      }
                                    },
                                    child: Stack(children: [
                                      getCardView(
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
                                                      visible:
                                                          (mGetCategoryItemListData
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
                                                          ImageAssetsConstants
                                                              .backLogo,
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
                                                  mGetCategoryItemListData
                                                          .itemName ??
                                                      '',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: getText600(
                                                      size: 15.sp,
                                                      colors: ColorConstants
                                                          .cAppColorsBlue,
                                                      heights: 1.3),
                                                ),
                                              ),
                                              Container(
                                                height: 4.h,
                                                margin: EdgeInsets.only(
                                                    left: 8.sp, right: 8.sp),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${controller.mDashboardScreenController.selectedCurrency.value} ${mGetCategoryItemListData.price ?? ''}',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: getText500(
                                                      size: 15.sp,
                                                      colors:
                                                          ColorConstants.black),
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                      Visibility(
                                          visible: ((mGetCategoryItemListData
                                                  .isStockOut ??
                                              false)),
                                          child: Container(
                                              margin: EdgeInsets.all(10.sp),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.65),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.sp),
                                              ),
                                              height: 32.5.h,
                                              child: Center(
                                                child: Text("Stock Out",
                                                    textAlign: TextAlign.center,
                                                    style: getText500(
                                                        colors: Colors.red,
                                                        size: 22.sp)),
                                              )))
                                    ]));
                              },
                            )))
            ],
          ),
        );
      },
    );
  }
}

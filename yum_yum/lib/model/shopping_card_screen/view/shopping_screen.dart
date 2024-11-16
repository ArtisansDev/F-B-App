// ignore_for_file: unrelated_type_equality_checks

import 'dart:math';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:my_coffee/model/shopping_card_screen/view/shopping_drinkware/shopping_drinkware_list_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/app_utils.dart';
import '../controller/shoping_screen_controller.dart';
import 'shopping_bundles/shopping_bundles_list_screen.dart';
import 'shopping_coffee/shopping_coffee_list_screen.dart';

class ShoppingScreen extends GetView<ShoppingScreenController> {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShoppingScreenController());
    controller.mShoppingDrinkwareListCount.value = Random().nextInt(11) + 1;
    controller.mShoppingCoffeeListCount.value = Random().nextInt(11) + 1;
    controller.mShoppingBundlesListCount.value = Random().nextInt(11) + 1;
    return _fullView();
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child:  mHomeView()));
  }

  mHomeView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [topView(),  shoppingListView()],
    );
  }

  topView() {
    return Obx(
      () {
        return Container(
          margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 18.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  controller.onChangePage(0);
                },
                child: Column(
                  children: [
                    Text(
                      'Drinkwae',
                      style: controller.mPageIndex.value == 0
                          ? getText600(
                              colors: ColorConstants.cAppColors.shade400,
                              size: 15.5.sp)
                          : getTextRegular(
                              colors: ColorConstants.cAppColors.shade50,
                              size: 15.5.sp),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                      width: 15.w,
                      height: 6.sp,
                      color: controller.mPageIndex.value == 0
                          ? ColorConstants.cAppColors.shade400
                          : Colors.transparent,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 15.sp,
              ),
              GestureDetector(
                onTap: () {
                  controller.onChangePage(1);
                },
                child: Column(
                  children: [
                    Text(
                      'Coffee',
                      style: controller.mPageIndex.value == 1
                          ? getText600(
                              colors: ColorConstants.cAppColors.shade400,
                              size: 15.5.sp)
                          : getTextRegular(
                              colors: ColorConstants.cAppColors.shade50,
                              size: 15.5.sp),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                      width: 15.w,
                      height: 6.sp,
                      color: controller.mPageIndex.value == 1
                          ? ColorConstants.cAppColors.shade400
                          : Colors.transparent,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 15.sp,
              ),
              GestureDetector(
                onTap: () {
                  controller.onChangePage(2);
                },
                child: Column(
                  children: [
                    Text(
                      'Bundles',
                      style: controller.mPageIndex.value == 2
                          ? getText600(
                              colors: ColorConstants.cAppColors.shade400,
                              size: 15.5.sp)
                          : getTextRegular(
                              colors: ColorConstants.cAppColors.shade50,
                              size: 15.5.sp),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                      width: 15.w,
                      height: 6.sp,
                      color: controller.mPageIndex.value == 2
                          ? ColorConstants.cAppColors.shade400
                          : Colors.transparent,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Shop All >',
                    style: getText500(
                        colors: ColorConstants.cAppColors.shade50,
                        size: 15.5.sp),
                  ),
                ),
              ))
            ],
          ),
        );
      },
    );
  }

  shoppingListView() {
    return Obx(() {
      return shoppingPageView(controller.mPageIndex.value);
    });
  }

  shoppingPageView(int index) {
    switch (index) {
      case 0:
        return ShoppingDrinkwareListScreen();
      case 1:
        return ShoppingCoffeeListScreen();
      case 2:
        return ShoppingBundlesListScreen();
    }
  }
}

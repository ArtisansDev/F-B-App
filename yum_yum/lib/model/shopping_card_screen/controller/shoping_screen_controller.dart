import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShoppingScreenController extends GetxController {
  // final Rx<PageController> introductionPageController =
  // PageController(initialPage: 0).obs;

  RxInt mPageIndex = 0.obs;
  RxInt mShoppingDrinkwareListCount = 0.obs;
  RxInt mShoppingCoffeeListCount = 0.obs;
  RxInt mShoppingBundlesListCount = 0.obs;

  void onChangePage(int value) {
    mPageIndex.value = value;
  }
}

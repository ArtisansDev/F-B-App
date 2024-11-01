/*
 * Project      : my_coffee
 * File         : order_utils.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-01
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:convert';

import 'package:get/get.dart';

import '../common/tag_view/tag_modifier_date_view.dart';
import '../common/tag_view/tag_variant_date_view.dart';
import '../data/local/shared_prefs/shared_prefs.dart';
import '../data/mode/add_cart/add_cart.dart';
import '../data/mode/get_item_details/get_item_details_response.dart';
import '../model/dashboard_screen/controller/dashboard_controller.dart';

///save cart view
saveCart(
    GetItemDetailsData mGetItemDetailsData,
    int count,
    TagModifierDateView mTagModifierDateView,
    TagVariantDateView mTagVariantDateView,
    double totalAmount,
    double amount,
    double amountModifier) async {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();

  ///add item
  GetItemDetailsData mItemsData = mGetItemDetailsData;
  mItemsData.count = count;
  mItemsData.selectModifierData = [];
  mItemsData.selectModifierData?.addAll(mTagModifierDateView.selectTag);
  mItemsData.selectVariantData = [];
  mItemsData.selectVariantData
      ?.add(mTagVariantDateView.selectVariantData.value);
  mItemsData.total = totalAmount;
  mItemsData.perItemTotal = (amount + amountModifier);

  ///add cart
  mAddCartModel.totalAmount = (mAddCartModel.totalAmount ?? 0) + totalAmount;
  mAddCartModel.mGetAllBranchesListData ??=
      mDashboardScreenController.selectGetAllBranchesListData.value;
  if ((mAddCartModel.mItems ?? []).isEmpty) {
    mAddCartModel.mItems = [];
  }
  mAddCartModel.mItems?.add(mItemsData);

  ///saveCartData
  await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
}

///edit cart view
editCart(
    GetItemDetailsData mGetItemDetailsData,
    int count,
    TagModifierDateView mTagModifierDateView,
    TagVariantDateView mTagVariantDateView,
    double totalAmount,
    double amount,
    double amountModifier,
    int index) async {
  ///add item
  GetItemDetailsData mItemsData = mGetItemDetailsData;
  mItemsData.count = count;
  mItemsData.selectModifierData = [];
  mItemsData.selectModifierData?.addAll(mTagModifierDateView.selectTag);
  mItemsData.selectVariantData = [];
  mItemsData.selectVariantData
      ?.add(mTagVariantDateView.selectVariantData.value);
  mItemsData.total = totalAmount;
  mItemsData.perItemTotal = (amount + amountModifier);

  ///add cart
  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;
  mAddCartModel.value = await SharedPrefs().getAddCartData();
  mAddCartModel.value.mItems![index] = mItemsData;

  mAddCartModel.value.totalAmount = 0.0;
  for (GetItemDetailsData mGetItemDetailsData
      in mAddCartModel.value.mItems ?? []) {
    mAddCartModel.value.totalAmount = (mAddCartModel.value.totalAmount ?? 0.0) +
        (mGetItemDetailsData.total ?? 0);
  }

  ///saveCartData
  await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
}

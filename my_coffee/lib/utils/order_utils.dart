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

import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_item_details/get_item_details_response.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../common/tag_view/tag_modifier_date_view.dart';
import '../common/tag_view/tag_variant_date_view.dart';
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
  ///DashboardScreenController
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///get mAddCartModel
  AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
  bool bFlag = true;
  int index = -1;
  if ((mAddCartModel.mItems ?? []).isNotEmpty) {
    for (GetItemDetailsData mMenuCartItem in (mAddCartModel.mItems ?? [])) {
      index++;
      mGetItemDetailsData.selectModifierData = [];
      mGetItemDetailsData.selectModifierData?.addAll(mTagModifierDateView.selectTag);
      mGetItemDetailsData.selectVariantData = [];
      mGetItemDetailsData.selectVariantData
          ?.add(mTagVariantDateView.selectVariantData.value);

      if (mMenuCartItem.selectVariantData?.first.quantitySpecification
              .toString() ==
          mTagVariantDateView.selectVariantData.value.quantitySpecification
              .toString()) {
        if (mMenuCartItem.getModifierString() ==
            mGetItemDetailsData.getModifierString()) {
          bFlag = false;
          break;
        }
      }
    }
  }

  if (bFlag) {
    ///add item
    GetItemDetailsData mItemsData = mGetItemDetailsData;
    mItemsData.count = count;
    mItemsData.selectModifierData = [];
    mItemsData.selectModifierData?.addAll(mTagModifierDateView.selectTag);
    mItemsData.selectVariantData = [];
    mItemsData.selectVariantData
        ?.add(mTagVariantDateView.selectVariantData.value);
    mItemsData.total = totalAmount;
    mItemsData.amountModifier = amountModifier;
    mItemsData.amount = amount;
    mItemsData.perItemTax =
        calculatePercentageOf(amount, mItemsData.itemTax ?? 0);
    mItemsData.perItemTotal = (amount + amountModifier);

    ///add cart
    mAddCartModel.totalAmount = (mAddCartModel.totalAmount ?? 0) + totalAmount;
    mAddCartModel.mGetAllBranchesListData ??=
        mDashboardScreenController.selectGetAllBranchesListData.value;
    if ((mAddCartModel.mItems ?? []).isEmpty) {
      mAddCartModel.mItems = [];
    }
    mAddCartModel.mItems?.add(mItemsData);

    await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
  } else {
    GetItemDetailsData mSelectItemsData = (mAddCartModel.mItems ?? [])[index];
    mSelectItemsData.count = (mSelectItemsData.count ?? 0) + count;
    mSelectItemsData.total = (mSelectItemsData.total ?? 0) + totalAmount;
    mAddCartModel.totalAmount = (mAddCartModel.totalAmount ?? 0) + totalAmount;

    (mAddCartModel.mItems ?? [])[index] = mSelectItemsData;
    await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
  }
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
  mItemsData.amountModifier = amountModifier;
  mItemsData.amount = amount;
  mItemsData.perItemTax =
      calculatePercentageOf(amount, mItemsData.itemTax ?? 0);
  mItemsData.perItemTotal = (amount + amountModifier);

  ///add cart
  AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
  mAddCartModel.mItems![index] = mItemsData;

  mAddCartModel.totalAmount = 0.0;
  for (GetItemDetailsData mGetItemDetailsData in mAddCartModel.mItems ?? []) {
    mAddCartModel.totalAmount =
        (mAddCartModel.totalAmount ?? 0.0) + (mGetItemDetailsData.total ?? 0);
  }

  ///saveCartData
  await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
}

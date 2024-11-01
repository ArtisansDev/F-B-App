// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../alert/app_alert.dart';
import '../../../common/tag_view/tag_modifier_date_view.dart';
import '../../../common/tag_view/tag_variant_date_view.dart';
import '../../../common/tag_view/tag_view.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/add_cart/add_cart.dart';
import '../../../data/mode/add_cart_details/add_cart_details.dart';
import '../../../data/mode/get_item_details/get_item_details_request.dart';
import '../../../data/mode/get_item_details/get_item_details_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/network_utils.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class DetailsEditPageController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  // late String itemId;
  final int index;

  // TagView mTemperature = TagView(['Hot', 'Iced']);
  // TagView mMilk = TagView(
  //     ['Dairy', 'Soy (+RM 2.00)', 'Almond (+RM 3.00)', 'OATSIDE (+RM 3.00)']);
  // TagView mCoffee = TagView(['No Shot', '+LYDIA (+RM 2.00)']);
  // TagView mSweetness = TagView(['Regular Sugar', 'Less Sugar']);

  RxDouble amountModifier = 0.0.obs;
  RxString sModifier = ''.obs;
  RxString sVariant = ''.obs;
  RxDouble amount = 0.0.obs;
  RxDouble totalAmount = 0.00.obs;
  RxInt count = 1.obs;
  late TagVariantDateView mTagVariantDateView;
  late TagModifierDateView mTagModifierDateView;

  void priceIncDec() {
    totalAmount.value = ((amount.value + amountModifier.value) * count.value);
  }

  void buyNow() async {
    await saveCart();
    Get.offNamed(RouteConstants.rOrderConfirmationScreen);
  }

  Rx<GetItemDetailsData> mGetItemDetailsData = GetItemDetailsData().obs;
  RxList<ItemImages> itemImages = <ItemImages>[].obs;
  RxList<VariantData> mVariantData = <VariantData>[].obs;
  RxList<ModifierData> mModifierData = <ModifierData>[].obs;
  Rx<PageController> introductionPageController =
      PageController(initialPage: 0).obs;
  RxList<ModifierData> selectModifierData = <ModifierData>[].obs;
  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;

  DetailsEditPageController(this.index) {
    setDetails();
  }

  void setDetails() async {
    mAddCartModel.value = await SharedPrefs().getAddCartData();
    mTagVariantDateView = TagVariantDateView((VariantData mVariantData) {
      amount.value = mVariantData.price ?? 0.0;
      sVariant.value = mVariantData.quantitySpecification ?? '';
      priceIncDec();
    });
    mTagModifierDateView =
        TagModifierDateView((List<ModifierData> mModifierDataList) {
      setModifier(mModifierDataList.toList());
      priceIncDec();
    });
    getItemDetailsApi();
  }

  setModifier(List<ModifierData> mModifierDataList) {
    selectModifierData.value.clear();
    selectModifierData.value.addAll(mModifierDataList.toList());
    amountModifier.value = 0.0;
    sModifier.value = '';
    String value = '';
    if (mModifierDataList.isNotEmpty) {
      for (ModifierData mModifierData in mModifierDataList) {
        amountModifier.value =
            amountModifier.value + (mModifierData.price ?? 0);
        value = "$value, ${mModifierData.modifierName}";
      }
      value = value.substring(1).trim();
      sModifier.value = value;
    }
  }

  void getItemDetailsApi() {
    mGetItemDetailsData.value = mAddCartModel.value.mItems![index];
    mGetItemDetailsData.refresh();

    itemImages.value.clear();
    itemImages.value.addAll(mGetItemDetailsData.value.itemImages ?? []);
    itemImages.refresh();

    mModifierData.value.clear();
    mModifierData.value.addAll(mGetItemDetailsData.value.modifierData ?? []);
    mModifierData.refresh();

    mVariantData.value.clear();
    mVariantData.value.addAll(mGetItemDetailsData.value.variantData ?? []);
    mVariantData.refresh();
    if ((mGetItemDetailsData.value.selectVariantData ?? []).isNotEmpty) {
      amount.value =
          mGetItemDetailsData.value.selectVariantData?.first.price ?? 0.0;
      sVariant.value = mGetItemDetailsData
              .value.selectVariantData?.first.quantitySpecification ??
          '';
      mTagVariantDateView.selectVariantData.value =
          mGetItemDetailsData.value.selectVariantData!.first;
    } else {
      amount.value = mVariantData.first.price ?? 0.0;
      sVariant.value = mVariantData.first.quantitySpecification ?? '';
    }
    if ((mGetItemDetailsData.value.selectModifierData ?? []).isNotEmpty) {
      mTagModifierDateView.selectTag.value.clear();
      mTagModifierDateView.selectTag.value.addAll(
          (mGetItemDetailsData.value.selectModifierData ?? []).toList());
      setModifier(
          (mGetItemDetailsData.value.selectModifierData ?? []).toList());
    }
    count.value = mGetItemDetailsData.value.count ?? 1;
    priceIncDec();
  }

  ///editOrder
  editOrder() async {
    await saveCart();
    Get.back();
  }

  saveCart() async {
    ///add item
    GetItemDetailsData mItemsData = mGetItemDetailsData.value;
    mItemsData.count = count.value;
    mItemsData.selectModifierData = [];
    mItemsData.selectModifierData?.addAll(mTagModifierDateView.selectTag);
    mItemsData.selectVariantData = [];
    mItemsData.selectVariantData
        ?.add(mTagVariantDateView.selectVariantData.value);
    mItemsData.total = totalAmount.value;
    mItemsData.perItemTotal = (amount.value + amountModifier.value);

    ///add cart
    mAddCartModel.value.mItems![index] = mItemsData;

    mAddCartModel.value.totalAmount = 0.0;
    for (GetItemDetailsData mGetItemDetailsData
        in mAddCartModel.value.mItems ?? []) {
      mAddCartModel.value.totalAmount =
          (mAddCartModel.value.totalAmount ?? 0.0) +
              (mGetItemDetailsData.total ?? 0);
    }

    ///saveCartData
    await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
  }
}

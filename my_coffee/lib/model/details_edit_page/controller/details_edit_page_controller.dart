// ignore_for_file: prefer_interpolation_to_compose_strings


import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_item_details/get_item_details_response.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/tag_view/tag_modifier_date_view.dart';
import '../../../common/tag_view/tag_variant_date_view.dart';
import '../../../utils/order_utils.dart';
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
  RxDouble taxP = 0.0.obs;
  RxDouble totalAmount = 0.00.obs;
  RxInt count = 1.obs;
  late TagVariantDateView mTagVariantDateView;
  late TagModifierDateView mTagModifierDateView;

  void priceIncDec() {
    double taxAmount = calculatePercentageOf(amount.value, taxP.value);
    totalAmount.value = ((amount.value + amountModifier.value +taxAmount) * count.value);
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
      if ((mVariantData.discountPercentage ?? 0) == 0) {
        amount.value = mVariantData.price ?? 0.0;
      } else {
        amount.value = mVariantData.discountedPrice ?? 0.0;
      }
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
      if((mGetItemDetailsData.value.selectVariantData?.first.discountPercentage??0)==0) {
        amount.value =mGetItemDetailsData.value.selectVariantData?.first.price ?? 0.0;
      }else {
        amount.value = mGetItemDetailsData.value.selectVariantData?.first.discountedPrice ?? 0.0;
      }
      sVariant.value = mGetItemDetailsData
              .value.selectVariantData?.first.quantitySpecification ??
          '';
      mTagVariantDateView.selectVariantData.value =
          mGetItemDetailsData.value.selectVariantData!.first;
    } else {
      if((mVariantData.first.discountPercentage??0)==0) {
        amount.value = mVariantData.first.price ?? 0.0;
      }else {
        amount.value = mVariantData.first.discountedPrice ?? 0.0;
      }
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
    ///tax
    taxP.value = mGetItemDetailsData.value.itemTax ?? 0;
    priceIncDec();
  }

  ///editOrder
  editOrder() async {
    await editCart(
        mGetItemDetailsData.value,
        count.value,
        mTagModifierDateView,
        mTagVariantDateView,
        totalAmount.value,
        amount.value,
        amountModifier.value,
        index);
    Get.back();
  }
}

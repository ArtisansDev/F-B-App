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
import '../../../utils/order_utils.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class DetailsPageScreenController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  final String itemId;

  RxDouble amountModifier = 0.0.obs;
  RxString sModifier = ''.obs;
  RxString sVariant = ''.obs;
  RxDouble amount = 0.0.obs;
  RxDouble totalAmount = 0.00.obs;
  RxInt count = 1.obs;
  late TagVariantDateView mTagVariantDateView;
  late TagModifierDateView mTagModifierDateView;
  Rx<GetItemDetailsData> mGetItemDetailsData = GetItemDetailsData().obs;
  RxList<ItemImages> itemImages = <ItemImages>[].obs;
  RxList<VariantData> mVariantData = <VariantData>[].obs;
  RxList<ModifierData> mModifierData = <ModifierData>[].obs;
  Rx<PageController> introductionPageController =
      PageController(initialPage: 0).obs;
  RxList<ModifierData> selectModifierData = <ModifierData>[].obs;

  void priceIncDec() {
    totalAmount.value = ((amount.value + amountModifier.value) * count.value);
  }

  void buyNow() async {
    await saveCart(
        mGetItemDetailsData.value,
        count.value,
        mTagModifierDateView,
        mTagVariantDateView,
        totalAmount.value,
        amount.value,
        amountModifier.value);
    Get.offNamed(RouteConstants.rOrderConfirmationScreen);
  }

  DetailsPageScreenController(this.itemId) {
    mTagVariantDateView = TagVariantDateView((VariantData mVariantData) {
      amount.value = mVariantData.price ?? 0.0;
      sVariant.value = mVariantData.quantitySpecification ?? '';
      priceIncDec();
    });
    mTagModifierDateView =
        TagModifierDateView((List<ModifierData> mModifierDataList) {
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
        priceIncDec();
      }
    });
    getItemDetailsApi();
  }

  void getItemDetailsApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetItemDetailsRequest mGetItemDetailsRequest = GetItemDetailsRequest(
          id:
              // '60782F37-FDB5-4434-A16A-7E9274792C97'
              itemId,
        );
        WebResponseSuccess mWebResponseSuccess =
            await AllApiImpl().postGetItemDetails(mGetItemDetailsRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetItemDetailsResponse mGetItemDetailsResponse =
              mWebResponseSuccess.data;
          if ((mGetItemDetailsResponse.data ?? []).isNotEmpty) {
            mGetItemDetailsData.value = mGetItemDetailsResponse.data!.first;
            mGetItemDetailsData.refresh();

            itemImages.value.clear();
            itemImages.value.addAll(mGetItemDetailsData.value.itemImages ?? []);
            itemImages.refresh();

            mModifierData.value.clear();
            mModifierData.value
                .addAll(mGetItemDetailsData.value.modifierData ?? []);
            mModifierData.refresh();

            mVariantData.value.clear();
            mVariantData.value
                .addAll(mGetItemDetailsData.value.variantData ?? []);
            mVariantData.refresh();
            if (mVariantData.isNotEmpty) {
              amount.value = mVariantData.first.price ?? 0.0;
              sVariant.value = mVariantData.first.quantitySpecification ?? '';
              priceIncDec();
            }
          }
        } else {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  String getNutritionalInfo() {
    String nutritionalInfo = mGetItemDetailsData.value.nutritionalInfo ?? '';
    if (nutritionalInfo.isNotEmpty) {
      nutritionalInfo = nutritionalInfo.replaceAll(',', ' | ');
      nutritionalInfo = nutritionalInfo.replaceAll('-', ' ');
    }
    return nutritionalInfo;
  }

  ///addCart
  addCart() async {
    await saveCart(
        mGetItemDetailsData.value,
        count.value,
        mTagModifierDateView,
        mTagVariantDateView,
        totalAmount.value,
        amount.value,
        amountModifier.value);
    Get.until((route) {
      return route.settings.name ==
          RouteConstants
              .rDashboardScreen; // Goes back until reaching '/dashboard'
    });
  }
}

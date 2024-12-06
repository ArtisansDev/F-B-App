// ignore_for_file: depend_on_referenced_packages

/*
 * Project      : my_coffee
 * File         : traking_order_id.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-11
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

import '../data/local/shared_prefs/shared_prefs.dart';
import '../data/mode/add_cart/add_cart.dart';
import '../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../data/mode/get_general_setting/get_general_setting_response.dart';
import '../data/mode/get_item_details/get_item_details_response.dart';
import '../data/mode/order_place/order_place_request.dart';
import '../data/mode/user_details/user_details_response.dart';
import 'num_utils.dart';

String getTrackingOrderID(
    String userIDF, String restaurentIDP, String branchIDF) {
  final combinedString =
      '$userIDF$restaurentIDP$branchIDF${DateTime.now().millisecondsSinceEpoch}';
  final bytes = utf8.encode(combinedString);
  final digest = sha1.convert(bytes);
  return digest.toString();
}

createOrderPlaceRequest(
    {String? remarksController,
    String? orderDate,
    AddCartModel? mAddCartModel,
    PaymentTypeResponseData? mPaymentTypeResponseData}) async {
  ///get store details
  GetAllBranchesListData selectGetAllBranchesListData =
      mAddCartModel!.mGetAllBranchesListData ?? GetAllBranchesListData();

  UserDetailsResponseData mUserDetailsResponseData =
      await SharedPrefs().getUserDetails();
  String restaurantIDF =
      (await SharedPrefs().getGeneralSetting()).restaurantIDF ?? '';

  ///trackingOrderID create
  String trackingOrderID = getTrackingOrderID(
      mUserDetailsResponseData.userID.toString(),
      restaurantIDF,
      selectGetAllBranchesListData.branchIDP ?? '');
  double totalAmount = 0.0;
  double modifierTotal = 0.0;
  double itemTaxTotal = 0.0;
  double discountTotal = 0.0;
  int quantityTotal = 0;
  List<OrderMenu> orderMenu = [];

  ///Item calculation
  for (GetItemDetailsData mGetItemDetailsData in mAddCartModel.mItems ?? []) {
    ///original total
    var subTotalAmount = 0.0;
    subTotalAmount = (mGetItemDetailsData.selectVariantData?.first.price ?? 0);
    totalAmount =
        totalAmount + (subTotalAmount * (mGetItemDetailsData.count ?? 0));

    ///discount
    var subDiscountTotal = 0.0;
    if ((mGetItemDetailsData.selectVariantData?.first.discountPercentage ?? 0) >
        0) {
      subDiscountTotal =
          (mGetItemDetailsData.selectVariantData?.first.discountedPrice ?? 0);
      subDiscountTotal = (subTotalAmount - subDiscountTotal);
      discountTotal =
          discountTotal + (subDiscountTotal * (mGetItemDetailsData.count ?? 0));

      ///new total /item
      subTotalAmount = subTotalAmount - subDiscountTotal;
    }

    ///modifier
    var subModifierTotal = 0.0;
    String allModifierIDF = '';
    String allModifierPrices = '';
    for (ModifierData mModifierData
        in mGetItemDetailsData.selectModifierData ?? []) {
      subModifierTotal = subModifierTotal + (mModifierData.price ?? 0);
      allModifierIDF = '$allModifierIDF${mModifierData.modifierIDP ?? ''},';
      allModifierPrices = '$allModifierPrices${mModifierData.price ?? ''},';
    }

    if (subModifierTotal > 0) {
      subModifierTotal = subModifierTotal * (mGetItemDetailsData.count ?? 0);
      allModifierIDF = allModifierIDF.substring(0, allModifierIDF.length - 1);
      allModifierPrices =
          allModifierPrices.substring(0, allModifierPrices.length - 1);
      modifierTotal = modifierTotal + subModifierTotal;
    }

    ///Item tax
    double subTotalTax = 0.0;
    if ((mGetItemDetailsData.itemTax ?? 0.0) > 0) {
      subTotalTax = calculatePercentageOf(
          subTotalAmount, mGetItemDetailsData.itemTax ?? 0.0);
      itemTaxTotal =
          itemTaxTotal + (subTotalTax * (mGetItemDetailsData.count ?? 0));
    }

    ///quantity
    quantityTotal = quantityTotal + (mGetItemDetailsData.count ?? 0);

    ///Item add
    OrderMenu mOrderMenu = OrderMenu(
        menuItemIDF: mGetItemDetailsData.menuItemIDP,
        variantIDF:
            mGetItemDetailsData.selectVariantData?.first.variantIDP ?? '',
        itemName: mGetItemDetailsData.itemName,
        quantity: (mGetItemDetailsData.count ?? 0),

        ///variant
        variantPrice: mGetItemDetailsData.selectVariantData?.first.price,
        itemVariantName: mGetItemDetailsData
                .selectVariantData?.first.quantitySpecification ??
            '',
        itemTotal: (mGetItemDetailsData.selectVariantData?.first.price ?? 0) *
            (mGetItemDetailsData.count ?? 0),
        itemDiscountPrice:
            mGetItemDetailsData.selectVariantData?.first.discountedPrice,
        discountedItemAmount:
            (mGetItemDetailsData.selectVariantData?.first.price ?? 0) -
                (mGetItemDetailsData.selectVariantData?.first.discountedPrice ??
                    0),
        itemDiscountPriceTotal:
            (mGetItemDetailsData.selectVariantData?.first.discountedPrice ??
                    0) *
                (mGetItemDetailsData.count ?? 0),
        discountPercentage:
            mGetItemDetailsData.selectVariantData?.first.discountPercentage,
        discountedItemTotalAmount:
            subDiscountTotal * (mGetItemDetailsData.count ?? 0),

        ///Modifier
        allModifierPrices: allModifierPrices,
        allModifierIDFs: allModifierIDF,
        itemModifierTotal: subModifierTotal,

        ///tax
        itemTaxPercent: mGetItemDetailsData.itemTax,
        itemTaxPrice: subTotalTax,
        itemTotalTaxPrice: subTotalTax * (mGetItemDetailsData.count ?? 0),

        ///Total
        totalItemAmount: ((subTotalAmount + subTotalTax) *
                (mGetItemDetailsData.count ?? 0)) +
            subModifierTotal);
    debugPrint("\nmOrderMenu:   ${jsonEncode(mOrderMenu)}\n");

    orderMenu.add(mOrderMenu);
  }

  ///subTotal calculation
  double subTotal = totalAmount + modifierTotal + itemTaxTotal - discountTotal;

  ///tax calculation
  double taxTotal = 0.0;
  List<OrderTax> orderTaxList = [];
  for (TaxData mTaxData in selectGetAllBranchesListData.taxData ?? []) {
    double subTaxTotal =
        calculatePercentageOf(subTotal, mTaxData.taxPercentage ?? 0.0);
    taxTotal = taxTotal + subTaxTotal;
    OrderTax mOrderTax = OrderTax(
        taxIDP: mTaxData.taxIDP ?? '',
        taxName: mTaxData.taxName ?? '',
        taxPercentage: mTaxData.taxPercentage ?? 0.0,
        taxAmount: subTaxTotal);

    ///OrderPlaceRequest
    debugPrint("\ntax calculation:   ${jsonEncode(mOrderTax)}\n");
    orderTaxList.add(mOrderTax);
  }

  ///OrderPlaceRequest
  OrderPlaceRequest mOrderPlaceRequest = OrderPlaceRequest(
    trackingOrderID: trackingOrderID,
    orderSource: "1",
    orderType: mAddCartModel.sType == 'Dine' ? '1' : '2',
    orderNo: '',
    branchIDF: selectGetAllBranchesListData.branchIDP,
    userIDF: mUserDetailsResponseData.userID,
    restaurentIDP: restaurantIDF,
    additionalNotes: remarksController ?? '',
    orderDate: orderDate,

    ///quantityTotal
    quantityTotal: quantityTotal,

    ///subTotal
    itemTotal: totalAmount,
    modifierTotal: modifierTotal,
    itemTaxTotal: itemTaxTotal,
    discountTotal: discountTotal,
    subTotal: subTotal,

    ///grandTotal
    taxAmountTotal: getDoubleValue(taxTotal),
    totalAmount: getDoubleValue(subTotal + taxTotal),
    grandTotal: getDoubleValue(subTotal + taxTotal),

    ///table no
    tableNo: mAddCartModel.sType == 'Dine'
        ? mAddCartModel.sTableNo
        :  '',

    ///payment_service
    paymentGatewayID: mPaymentTypeResponseData?.paymentGatewayIDP??'',
    paymentGatewaySettingID: mPaymentTypeResponseData?.paymentGatewaySettingIDP??'',

    ///orderTax
    orderTax: orderTaxList,

    ///orderMenu
    orderMenu: orderMenu,
  );

  return mOrderPlaceRequest;
}

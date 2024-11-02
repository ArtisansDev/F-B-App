import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/add_cart/add_cart.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../../data/mode/get_item_details/get_item_details_response.dart';
import '../../../routes/route_constants.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class OrderConfirmationScreenController extends GetxController {
  RxDouble totalAmount = 0.00.obs;
  RxInt totalCountItem = 0.obs;
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;
  RxList<GetItemDetailsData> mItems = <GetItemDetailsData>[].obs;
  Rx<TextEditingController> remarksController = TextEditingController().obs;

  OrderConfirmationScreenController() {
    getOrderDetails();
  }

  ///setLocation
  Rx<GetAllBranchesListData> selectGetAllBranchesListData =
      GetAllBranchesListData().obs;

  ///getStoreLocation
  void getStoreLocation() {
    selectGetAllBranchesListData.value =
        mDashboardScreenController.selectGetAllBranchesListData.value;
  }

  Rxn<DateTime> selectedDateTime = Rxn<DateTime>();

  ///select Date Time
  Future<void> selectDateAndTime() async {
    // Step 1: Select Date
    final DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 2),
      ),
    );

    if (selectedDate != null) {
      // Step 2: Select Time
      final TimeOfDay? selectedTime = await showTimePicker(
        context: Get.context!,
        initialEntryMode: TimePickerEntryMode.dialOnly,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        // Combine Date and Time into a single DateTime object
        final DateTime combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Set the selectedDateTime
        selectedDateTime.value = combinedDateTime;
      }
    }
  }

  ///OrderDetails
  void getOrderDetails() async {
    mAddCartModel.value = await SharedPrefs().getAddCartData();
    selectGetAllBranchesListData.value =
        mAddCartModel.value.mGetAllBranchesListData ?? GetAllBranchesListData();
    totalAmount.value = mAddCartModel.value.totalAmount ?? 0.0;
    mItems.clear();
    mItems.addAll((mAddCartModel.value.mItems ?? []).toList());
    itemModify();
    mAddCartModel.refresh();
  }

  ///IncDec
  void priceIncDec(
      GetItemDetailsData mGetItemDetailsData, int index, int count) async {
    mGetItemDetailsData.count = count;
    mGetItemDetailsData.total = (mGetItemDetailsData.perItemTotal ?? 0) *
        (mGetItemDetailsData.count ?? 0);
    mItems.value[index] = mGetItemDetailsData;
    totalAmount.value = 0.0;
    for (GetItemDetailsData mGetItemDetailsData in mItems) {
      totalAmount.value = totalAmount.value + (mGetItemDetailsData.total ?? 0);
    }
    mAddCartModel.value.mItems?.clear();
    mAddCartModel.value.mItems?.addAll(mItems);
    mAddCartModel.value.totalAmount = totalAmount.value;

    await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
    itemModify();
  }

  ///deleteOrder
  void deleteOrder(int index) async {
    mItems.value.removeAt(index);
    totalAmount.value = 0.0;
    for (GetItemDetailsData mGetItemDetailsData in mItems) {
      totalAmount.value = totalAmount.value + (mGetItemDetailsData.total ?? 0);
    }
    mAddCartModel.value.mItems?.clear();
    mAddCartModel.value.mItems?.addAll(mItems);
    mAddCartModel.value.totalAmount = totalAmount.value;

    await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
    if (totalAmount.value == 0.0) {
      Get.back();
    }
    itemModify();
  }

  itemModify(){
    totalCountItem.value = 0;
    for (GetItemDetailsData mGetItemDetailsData in mItems) {
      totalCountItem.value =
          totalCountItem.value + (mGetItemDetailsData.count ?? 0);
    }
    mItems.refresh();
  }

  ///editOrder
  void editOrder(int index) async {
    await Get.toNamed(RouteConstants.rDetailsEditPageScreen, arguments: index);
    getOrderDetails();
  }

  ///orderNow
  orderNow() async {
    if (await checkLoginStatus()) {
      Get.toNamed(RouteConstants.rLoginScreen);
    }
  }

  ///checkLogin
  checkLoginStatus() async {
    String sLoginStatus = await SharedPrefs().getUserToken();
    return sLoginStatus.isEmpty;
  }
}

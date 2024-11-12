import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/add_cart/add_cart.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../../data/mode/get_item_details/get_item_details_response.dart';
import '../../../data/mode/order_place/order_place_request.dart';
import '../../../data/mode/order_place/process_order_response.dart';
import '../../../data/mode/user_details/user_details_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/date_format.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/num_utils.dart';
import '../../../utils/tracking_order_id.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class OrderConfirmationScreenController extends GetxController {
  RxDouble totalAmount = 0.00.obs;
  RxDouble subTotalAmount = 0.00.obs;
  RxDouble totalTaxAmount = 0.00.obs;
  RxInt totalCountItem = 0.obs;
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;
  RxList<GetItemDetailsData> mItems = <GetItemDetailsData>[].obs;
  Rx<TextEditingController> remarksController = TextEditingController().obs;

  ///setLocation
  Rx<GetAllBranchesListData> selectGetAllBranchesListData =
      GetAllBranchesListData().obs;

  OrderConfirmationScreenController() {
    selectedDateTime.value = DateTime.now().toUtc();
    getOrderDetails();
  }

  RxInt paymentType = 0.obs;
  RxList<String> paymentTypeList = ['PayPal', 'Net Banking'].obs;

  paymentTypeSelect(int index) {
    paymentType.value = index;
    paymentType.refresh();
    paymentTypeList.refresh();
  }

  Rxn<DateTime> selectedDateTime = Rxn<DateTime>();

  ///select Date Time
  Future<void> selectDateAndTime() async {
    // Step 1: Select Date
    final DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now().toUtc(),
      firstDate: DateTime.now().toUtc(),
      lastDate: DateTime.now().toUtc().add(
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
    selectGetAllBranchesListData.value =
        mAddCartModel.value.mGetAllBranchesListData ?? GetAllBranchesListData();
    taxCalculation();
    mAddCartModel.refresh();
  }

  ///IncDec
  void priceIncDec(
      GetItemDetailsData mGetItemDetailsData, int index, int count) async {
    mGetItemDetailsData.count = count;
    mGetItemDetailsData.total = ((mGetItemDetailsData.perItemTotal ?? 0) +
            (mGetItemDetailsData.perItemTax ?? 0)) *
        (mGetItemDetailsData.count ?? 0);
    mItems.value[index] = mGetItemDetailsData;
    totalAmount.value = 0.0;
    for (GetItemDetailsData mGetItemDetailsData in mItems) {
      totalAmount.value = totalAmount.value + (mGetItemDetailsData.total ?? 0);
    }

    mAddCartModel.value.mItems?.clear();
    mAddCartModel.value.mItems?.addAll(mItems);
    mAddCartModel.value.totalAmount = totalAmount.value;
    taxCalculation();
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
    taxCalculation();
    await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
    if (totalAmount.value == 0.0) {
      Get.back();
    }
    itemModify();
  }

  itemModify() {
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
    } else {
      OrderPlaceRequest mOrderPlaceRequest = await createOrderPlaceRequest(
          remarksController: remarksController.value.text,
          orderDate: getUTCValue(selectedDateTime.value!),
          mAddCartModel: mAddCartModel.value);

      ///OrderPlaceRequest
      debugPrint("\nmOrderPlaceRequest:   ${jsonEncode(mOrderPlaceRequest)}\n");

      getOrderPlaceApi(mOrderPlaceRequest);
    }
  }

  ///taxCalculation
  void taxCalculation() {
    totalAmount.value;
    subTotalAmount.value = totalAmount.value;
    totalTaxAmount.value = 0.0;
    for (TaxData mTaxData in selectGetAllBranchesListData.value.taxData ?? []) {
      if ((mTaxData.taxPercentage ?? 0) > 0) {
        totalTaxAmount.value = totalTaxAmount.value +
            calculatePercentageOf(
                totalAmount.value, mTaxData.taxPercentage ?? 0);
      }
    }
    totalAmount.value = totalAmount.value + totalTaxAmount.value;
  }

  ///checkLogin
  checkLoginStatus() async {
    String sLoginStatus = await SharedPrefs().getUserToken();
    return sLoginStatus.isEmpty;
  }

  ///getOrderPlaceApi
  void getOrderPlaceApi(OrderPlaceRequest mOrderPlaceRequest) {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess =
            await AllApiImpl().postOrderPlace(mOrderPlaceRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          ProcessOrderResponse mProcessOrderResponse = mWebResponseSuccess.data;
          AppAlert.showSnackBar(Get.context!, 'Order place successfully');
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
}

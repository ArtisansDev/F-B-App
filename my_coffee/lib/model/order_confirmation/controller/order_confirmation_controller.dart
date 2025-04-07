import 'dart:convert';

import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/data/mode/get_all_table_status/set_table_status_request.dart';
import 'package:f_b_base/data/mode/get_general_setting/get_general_setting_response.dart';
import 'package:f_b_base/data/mode/get_item_details/get_item_details_response.dart';
import 'package:f_b_base/data/mode/order_history_gust/order_history_id_model.dart';
import 'package:f_b_base/data/mode/order_place/order_place_request.dart';
import 'package:f_b_base/data/mode/order_place/order_place_share.dart';
import 'package:f_b_base/data/mode/order_place/process_order_response.dart';
import 'package:f_b_base/data/mode/payment_type/payment_type_request.dart';
import 'package:f_b_base/data/mode/payment_type/payment_type_response.dart';
import 'package:f_b_base/data/remote/api_call/order/order_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/date_format.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:f_b_base/utils/tracking_order_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/logout_expired.dart';
import '../../../routes/route_constants.dart';
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
  final localApi = locator.get<OrderHistoryApi>();

  OrderConfirmationScreenController() {
    selectedDateTime.value = DateTime.now();
    getOrderPrefixCode();
  }

  Rxn<GetGeneralSettingData> mGetGeneralSettingData =
      Rxn<GetGeneralSettingData>();

  void getOrderPrefixCode() async {
    mGetGeneralSettingData.value =
        await SharedPrefs().getGetGeneralSettingData();
    await getOrderDetails();
    await getPaymentTypeApi();
  }

  ///PackagingData
  Rxn<PackagingData> mSelectPackagingData = Rxn<PackagingData>();

  packagingDataSelect(PackagingData mPackagingData) {
    if ((mSelectPackagingData.value?.packagingIDP ?? '').toString() ==
        mPackagingData.packagingIDP.toString()) {
      mSelectPackagingData.value = null;
    } else {
      mSelectPackagingData.value = mPackagingData;
    }
    mSelectPackagingData.refresh();
  }

  ///paymentType
  Rxn<int> paymentType = Rxn<int>();
  Rxn<PaymentTypeResponseData> selectPaymentType =
      Rxn<PaymentTypeResponseData>();
  RxList<PaymentTypeResponseData> paymentTypeList =
      <PaymentTypeResponseData>[].obs;

  paymentTypeSelect(int index) {
    paymentType.value = index;
    paymentType.refresh();
    paymentTypeList.refresh();

    ///
    selectPaymentType.value = paymentTypeList[index];
    selectPaymentType.refresh();
  }

  ///getPaymentTypeApi
  getPaymentTypeApi() async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        PaymentTypeRequest mPaymentTypeRequest = PaymentTypeRequest(
            restaurantIDF:
                (await SharedPrefs().getGeneralSetting()).restaurantIDF ?? '');
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postPaymentType(mPaymentTypeRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          PaymentTypeResponse mPaymentTypeResponse = mWebResponseSuccess.data;
          paymentTypeList.clear();
          paymentTypeList.addAll(mPaymentTypeResponse.data ?? []);

          if (kIsWeb) {
            paymentTypeList.removeWhere(
              (element) {
                return !((element.webDineInEnable ?? true));
              },
            );
          } else {
            paymentTypeList.removeWhere(
              (element) {
                return mAddCartModel.value.sType == 'Dine'
                    ? !((element.appDineInEnable ?? true))
                    : !((element.appTakeAwayEnable ?? true));
              },
            );
          }
          paymentTypeList.refresh();
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
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
  getOrderDetails() async {
    mAddCartModel.value = await SharedPrefs().getAddCartData();
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
    mItems[index] = mGetItemDetailsData;
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
    mItems.removeAt(index);
    totalAmount.value = 0.0;
    for (GetItemDetailsData mGetItemDetailsData in mItems) {
      totalAmount.value = totalAmount.value + (mGetItemDetailsData.total ?? 0);
    }
    mAddCartModel.value.mItems?.clear();
    mAddCartModel.value.mItems?.addAll(mItems);
    mAddCartModel.value.totalAmount = totalAmount.value;
    if (totalAmount.value == 0.0) {
      mAddCartModel.value.sOrderDateTime = "";
    }
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
      if (paymentType.value == null) {
        AppAlertBase.showSnackBar(
            Get.context!, 'Please select the payment type');
      } else {
        OrderPlaceRequest mOrderPlaceRequest = await createOrderPlaceRequest(
            remarksController: remarksController.value.text,
            orderDate: getUTCValue(selectedDateTime.value!),
            mAddCartModel: mAddCartModel.value,
            mPackagingData: mSelectPackagingData.value,
            mPaymentTypeResponseData:
                paymentTypeList.length > (paymentType.value ?? 0)
                    ? paymentTypeList[paymentType.value ?? 0]
                    : null);

        ///OrderPlaceRequest
        debugPrint(
            "\n mOrderPlaceRequest:   ${jsonEncode(mOrderPlaceRequest)}\n");
        bool value = true;
        if (kIsWeb) {
          if ((mOrderPlaceRequest.seatIDF ?? "").isEmpty ||
              (mOrderPlaceRequest.tableNo ?? "").isEmpty) {
            AppAlertBase.showSnackBar(Get.context!, 'Please scan the qrcode');
            return;
          }
        }

        if (mOrderPlaceRequest.orderType == '1' &&
            paymentTypeList[paymentType.value ?? 0]
                    .paymentGatewayNo
                    .toString() ==
                "0".toString()) {
          var returnValue = await getSetTableStatusApi(mOrderPlaceRequest);
          if (returnValue == null) {
            return;
          } else {
            value = returnValue;
          }
        }

        if (kIsWeb) {
          if (value) {
            OrderHistoryIdModel mOrderHistoryIdModel =
                await SharedPrefs().getOrderHistoryId();
            if (await SharedPrefs().getGuestUser()) {
              if ((mOrderHistoryIdModel.orderHistoryId ?? []).isEmpty) {
                mOrderHistoryIdModel = OrderHistoryIdModel(
                    orderHistoryId: [mOrderPlaceRequest.trackingOrderID ?? '']);
              } else {
                mOrderHistoryIdModel.orderHistoryId
                    ?.add(mOrderPlaceRequest.trackingOrderID ?? '');
              }
              await SharedPrefs()
                  .setOrderHistoryId(jsonEncode(mOrderHistoryIdModel));
            }
          }
        }

        if (value) {
          await getOrderPlaceApi(mOrderPlaceRequest);
        } else if (!value && mOrderPlaceRequest.orderType == '1') {
          AppAlertBase.showSnackBar(Get.context!, 'This table already book');
        }
      }
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

  ///Table Status
  getSetTableStatusApi(OrderPlaceRequest mOrderPlaceRequest) async {
    return await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        SetTableStatusRequest mSetTableStatusRequest = SetTableStatusRequest(
          userIDF: mOrderPlaceRequest.userIDF,
          seatIDP: await SharedPrefs().getSeatIDF(),
          trackingOrderID: mOrderPlaceRequest.trackingOrderID,
          tableStatus: 'O',
        );
        WebResponseSuccess mWebResponseSuccess = await locator
            .get<OrderHistoryApi>()
            .postSetTableStatus(mSetTableStatusRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          return true;
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode401) {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          logout();
          return null;
        } else {
          // AppAlertBase.showSnackBar(
          //     Get.context!, mWebResponseSuccess.statusMessage ?? '');
          return false;
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
        return false;
      }
    });
  }

  ///getOrderPlaceApi
  getOrderPlaceApi(OrderPlaceRequest mOrderPlaceRequest) {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postOrderPlace(mOrderPlaceRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          ProcessOrderResponse mProcessOrderResponse = mWebResponseSuccess.data;
          AppAlertBase.showSnackBar(Get.context!, 'Order place successfully');
          AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
          mAddCartModel.mItems = null;
          mAddCartModel.sOrderDateTime = '';
          mAddCartModel.totalAmount = 0.0;
          bool isGuestUser = await SharedPrefs().getGuestUser();
          if (kIsWeb && isGuestUser) {
          } else {
            // mAddCartModel.sTableNo = "";
            // mAddCartModel.sType = "";
          }

          await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
          OrderPlaceShare mOrderPlaceShare = OrderPlaceShare(
              data: mProcessOrderResponse.data ?? '',
              paymentGatewayNo: paymentTypeList.length >
                      (paymentType.value ?? 0)
                  ? paymentTypeList[(paymentType.value ?? 0)].paymentGatewayNo
                  : '0');
          await SharedPrefs().setProcessOrderId(jsonEncode(mOrderPlaceShare));
          mDashboardScreenController.selectedIndex.value = 2;
          mDashboardScreenController.selectTitle(2);
          Get.until((route) {
            return route.settings.name ==
                RouteConstants
                    .rDashboardScreen; // Goes back until reaching '/dashboard'
          });
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode401) {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          logout();
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}

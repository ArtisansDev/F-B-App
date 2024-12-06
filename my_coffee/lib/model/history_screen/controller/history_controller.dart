import 'dart:convert';
import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_request.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/data/mode/get_general_setting/get_general_setting_response.dart';
import 'package:f_b_base/data/mode/get_item_details/get_item_details_request.dart';
import 'package:f_b_base/data/mode/get_item_details/get_item_details_response.dart';
import 'package:f_b_base/data/mode/get_order_history/get_order_history_request.dart';
import 'package:f_b_base/data/mode/get_order_history/order_history_response.dart';
import 'package:f_b_base/data/mode/order_place/order_place_request.dart';
import 'package:f_b_base/data/mode/order_place/order_place_share.dart';
import 'package:f_b_base/data/mode/payment_type/payment_type_request.dart';
import 'package:f_b_base/data/mode/payment_type/payment_type_response.dart';
import 'package:f_b_base/data/mode/update_payment_status/update_payment_status_request.dart';
import 'package:f_b_base/data/mode/user_details/user_details_response.dart';
import 'package:f_b_base/data/remote/api_call/order/order_api.dart';
import 'package:f_b_base/data/remote/api_call/product_api/product_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/payment_service/razer_payment/model/razer_responce.dart';
import 'package:f_b_base/payment_service/razer_payment/razer_payment_service.dart';
import 'package:f_b_base/payment_service/senang_pay_payment/senang_pay_service.dart';
import 'package:f_b_base/utils/date_format.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:f_b_base/utils/num_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/route_constants.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class HistoryScreenController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  RxString showValue = 'Loading...'.obs;
  RxList<OrderHistoryResponseItemData> mOrderHistoryResponseItemData =
      <OrderHistoryResponseItemData>[].obs;
  final localApi = locator.get<OrderHistoryApi>();
  final productApi = locator.get<ProductApi>();

  ///Refresh
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool enablePullUp = false.obs;
  int pageNumber = 1;

  void onRefresh() async {
    showValue.value = 'Loading...';
    mOrderHistoryResponseItemData.value.clear();
    pageNumber = 1;
    getOrderHistoryApi();
  }

  void onLoadMore() async {
    pageNumber = pageNumber + 1;
    getOrderHistoryApi();
  }

  ///getOrderHistoryApi
  void getOrderHistoryApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UserDetailsResponseData mUserDetailsResponseData =
            await SharedPrefs().getUserDetails();
        GetOrderHistoryRequest mGetOrderHistoryRequest = GetOrderHistoryRequest(
            userIDF: mUserDetailsResponseData.userID,
            pageNumber: pageNumber,
            rowsPerPage: 10);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGetOrderHistory(mGetOrderHistoryRequest);
        if (refreshController.isRefresh) {
          refreshController.refreshCompleted();
        } else if (refreshController.isLoading) {
          refreshController.loadComplete();
        }
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          OrderHistoryResponse mOrderHistoryResponse = mWebResponseSuccess.data;
          mOrderHistoryResponseItemData.value
              .addAll((mOrderHistoryResponse.data?.data ?? []).toList());
          if (mOrderHistoryResponseItemData.isEmpty) {
            showValue.value = 'No history found';
          } else {
            OrderPlaceShare getProcessOrderId =
                await SharedPrefs().getProcessOrderId();
            await SharedPrefs().setProcessOrderId('');
            OrderHistoryResponseItemData mOrderHistoryItemData =
                mOrderHistoryResponseItemData.value.first;
            if (mOrderHistoryItemData.orderIDP.toString().toUpperCase() ==
                getProcessOrderId.data.toString().toUpperCase()) {
              selectPayment(mOrderHistoryItemData);
            }
          }
          showValue.value = '';
          enablePullUp.value = mOrderHistoryResponseItemData.value.length <
              (mOrderHistoryResponse.data?.totalRecords ?? 0);
          mOrderHistoryResponseItemData.refresh();
        } else {
          showValue.value = 'Internal server error';
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        showValue.value = MessageConstants.noInternetConnection;
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;

  void gotOrderHistoryDetails(int index) async {
    ///get data
    OrderHistoryResponseItemData mOrderHistoryResponse =
        mOrderHistoryResponseItemData.value[index];
    AppAlertBase.showProgressDialog(Get.context!);
    mAddCartModel.value = AddCartModel();
    await getGetAllBranchesApi(mOrderHistoryResponse.branchName ?? '',
        mOrderHistoryResponse.branchIDF ?? '');
    if (mAddCartModel.value.mGetAllBranchesListData?.branchIDP != 'null') {
      for (OrderMenu mOrderMenu in mOrderHistoryResponse.orderMenu ?? []) {
        await getItemDetailsApi(mOrderMenu);
      }
    }
    mAddCartModel.value.sType =
        ((mOrderHistoryResponse.orderType ?? 1) == 1) ? 'Dine' : 'Take';
    mAddCartModel.value.sOrderDateTime = mOrderHistoryResponse.orderDate ?? '';
    mAddCartModel.value.mOrderHistoryResponseItemData = mOrderHistoryResponse;
    AppAlertBase.hideLoadingDialog(Get.context!);
    if ((mAddCartModel.value.mItems ?? []).length ==
        (mOrderHistoryResponse.orderMenu ?? []).length) {
      Get.toNamed(RouteConstants.rOrderHistoryScreen,
          arguments: mAddCartModel.value);
    }
  }

  getGetAllBranchesApi(String search, String branchIDP) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetAllBranchesByRestaurantIdRequest
            mGetAllBranchesByRestaurantIdRequest =
            GetAllBranchesByRestaurantIdRequest(
                rowsPerPage: 0,
                pageNumber: pageNumber,
                searchValue: search,
                todayDate: toDayDate(),
                restaurantIDF:
                    (await SharedPrefs().getGeneralSetting()).restaurantIDF ??
                        '');
        WebResponseSuccess mWebResponseSuccess =
            await productApi.postGetAllBranchesByRestaurantID(
                mGetAllBranchesByRestaurantIdRequest,
                isLoading: false);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetAllBranchesByRestaurantIdResponse
              mGetAllBranchesByRestaurantIdResponse = mWebResponseSuccess.data;
          mAddCartModel.value.mGetAllBranchesListData =
              mGetAllBranchesByRestaurantIdResponse.data?.data?.firstWhere(
            (item) => (item.branchIDP ?? '').contains(branchIDP),
            orElse: () => GetAllBranchesListData(),
          );
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, 'Sorry Restaurant Branches Not found');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  getItemDetailsApi(OrderMenu mOrderMenu) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetItemDetailsRequest mGetItemDetailsRequest = GetItemDetailsRequest(
          id: mOrderMenu.menuItemIDF,
        );
        WebResponseSuccess mWebResponseSuccess = await productApi
            .postGetItemDetails(mGetItemDetailsRequest, isLoading: false);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetItemDetailsResponse mGetItemDetailsResponse =
              mWebResponseSuccess.data;
          if ((mGetItemDetailsResponse.data ?? []).isNotEmpty) {
            double totalAmount = mOrderMenu.totalItemAmount ?? 0.0;
            double amount = (mOrderMenu.itemDiscountPriceTotal ?? 1) /
                (mOrderMenu.quantity ?? 1);
            double amountModifier = (mOrderMenu.itemModifierTotal ?? 1) /
                (mOrderMenu.quantity ?? 1);

            ///add item
            GetItemDetailsData mItemsData = mGetItemDetailsResponse.data!.first;

            /// Find objects with IDs that match any ID in idArray
            List<ModifierData> commonObjects = [];
            if (amountModifier > 0) {
              List<String> idArray =
                  (mOrderMenu.allModifierIDFs ?? '').split(',');
              commonObjects = (mItemsData.modifierData ?? [])
                  .where((obj) => idArray.contains(obj.modifierIDP))
                  .toList();
            }
            VariantData mVariantData = mItemsData.variantData!.firstWhere(
              (element) {
                return (element.variantIDP ?? '').toUpperCase().trim() ==
                    (mOrderMenu.variantIDF ?? '').toUpperCase().trim();
              },
            );
            if (mVariantData.variantIDP == null) {
              mVariantData = VariantData(
                  variantIDP: (mOrderMenu.variantIDF ?? ''),
                  price: (mOrderMenu.variantPrice ?? 0.0),
                  discountedPrice: (mOrderMenu.itemDiscountPrice ?? 0.0),
                  discountPercentage: (mOrderMenu.discountPercentage ?? 0.0),
                  quantitySpecification: mOrderMenu.itemVariantName ?? '');
            }

            ///
            mItemsData.count = mOrderMenu.quantity;
            mItemsData.selectModifierData = [];
            mItemsData.selectModifierData?.addAll(commonObjects.toList());
            mItemsData.selectVariantData = [];
            mItemsData.selectVariantData?.add(mVariantData);
            mItemsData.total = totalAmount;
            mItemsData.amountModifier = amountModifier;
            mItemsData.amount = amount;
            mItemsData.perItemTax =
                calculatePercentageOf(amount, mItemsData.itemTax ?? 0);
            mItemsData.perItemTotal = (amount + amountModifier);

            ///add cart
            mAddCartModel.value.totalAmount =
                (mAddCartModel.value.totalAmount ?? 0) + totalAmount;
            mAddCartModel.value.mGetAllBranchesListData ??=
                mDashboardScreenController.selectGetAllBranchesListData.value;
            if ((mAddCartModel.value.mItems ?? []).isEmpty) {
              mAddCartModel.value.mItems = [];
            }
            mAddCartModel.value.mItems?.add(mItemsData);
          }
        } else {
          // AppAlertBase.showSnackBar(
          //     Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  // void onPaymentSelect(int index) async {
  //   paymentType.value = 0;
  //   if(paymentTypeList.value.isEmpty){
  //     await getPaymentTypeApi();
  //   }
  //   await AppAlertBase.showView(Get.context!,  PaymentHistoryMethodView(),
  //       barrierDismissible: true);
  //
  // }

  ///paymentType
  RxInt paymentType = 0.obs;
  RxList<PaymentTypeResponseData> paymentTypeList =
      <PaymentTypeResponseData>[].obs;

  paymentTypeSelect(int index) {
    paymentType.value = index;
    paymentType.refresh();
    paymentTypeList.refresh();
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
          paymentTypeList.value.clear();
          paymentTypeList.addAll(mPaymentTypeResponse.data ?? []);
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

  ///payment
  RxBool bFlagLoad = true.obs;

  selectPayment(
    OrderHistoryResponseItemData mOrderHistoryResponse,
  ) async {
    if ((mOrderHistoryResponse.paymentGatewayNo ?? 0).toString() == '1') {
      GetGeneralSettingData mGetGeneralSettingData =
          await SharedPrefs().getGeneralSetting();
      PaymentTypeResponseData? mPaymentResponses;
      for (var mGeneralSettingPaymentResponses
          in mGetGeneralSettingData.paymentResponses ?? []) {
        if (mGeneralSettingPaymentResponses.paymentGatewayNo == '1') {
          mPaymentResponses = mGeneralSettingPaymentResponses;
          break;
        }
      }
      senangPayNow(mOrderHistoryResponse,
          mPaymentResponses ?? PaymentTypeResponseData());
    } else if ((mOrderHistoryResponse.paymentGatewayNo ?? 0).toString() ==
        '2') {
      GetGeneralSettingData mGetGeneralSettingData =
          await SharedPrefs().getGeneralSetting();
      PaymentTypeResponseData? mPaymentResponses;
      for (var mGeneralSettingPaymentResponses
          in mGetGeneralSettingData.paymentResponses ?? []) {
        if (mGeneralSettingPaymentResponses.paymentGatewayNo == '2') {
          mPaymentResponses = mGeneralSettingPaymentResponses;
          break;
        }
      }

      razerPayNow(mOrderHistoryResponse,
          mPaymentResponses ?? PaymentTypeResponseData());
    } else {
      getUpdatePaymentStatusApi(mOrderHistoryResponse, '');
    }
  }

  ///getSubmitPayment
  getUpdatePaymentStatusApi(
      OrderHistoryResponseItemData mOrderHistoryResponse, String value,
      {String? sTransactionID}) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UpdatePaymentStatusRequest mUpdatePaymentStatusRequest =
            UpdatePaymentStatusRequest(
                restaurantIDF: mOrderHistoryResponse.restaurantIDF,
                userID: mOrderHistoryResponse.userIDF,
                orderID: mOrderHistoryResponse.orderIDP,
                paymentGatewayIDF: mOrderHistoryResponse.paymentGatewayIDF,
                paymentGatewayNo:
                    (mOrderHistoryResponse.paymentGatewayNo ?? 0).toString(),
                paymentGatewaySettingIDF:
                    mOrderHistoryResponse.paymentGatewaySettingIDF,
                paymentStatus: 'S',
                responseCode: '200',
                responseData: value,
                paidAmount: mOrderHistoryResponse.totalAmount,
                responseMessage: 'Transaction Successful',
                transactionID: sTransactionID ??
                    ((value.isEmpty || value.split('-').isEmpty)
                        ? ''
                        : value.split('-')[1]));
        debugPrint(
            "mUpdatePaymentStatusRequest ${jsonEncode(mUpdatePaymentStatusRequest)}");
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdatePaymentStatus(mUpdatePaymentStatusRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          AppAlertBase.showCustomDialogOk(
              Get.context!, sPaymentSuccessful.tr, sPaymentSuccessfulMessage.tr,
              () {
            onRefresh();
          }, rightText: 'Ok');
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

  getUpdatePaymentDeclinedApi(
      OrderHistoryResponseItemData mOrderHistoryResponse, String value,
      {String? sTransactionID}) async {

    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UpdatePaymentStatusRequest mUpdatePaymentStatusRequest =
            UpdatePaymentStatusRequest(
                restaurantIDF: mOrderHistoryResponse.restaurantIDF,
                userID: mOrderHistoryResponse.userIDF,
                orderID: mOrderHistoryResponse.orderIDP,
                paymentGatewayIDF: mOrderHistoryResponse.paymentGatewayIDF,
                paymentGatewayNo:
                    (mOrderHistoryResponse.paymentGatewayNo ?? 0).toString(),
                paymentGatewaySettingIDF:
                    mOrderHistoryResponse.paymentGatewaySettingIDF,
                paymentStatus: 'F',
                responseCode: '400',
                responseData: value,
                paidAmount: mOrderHistoryResponse.totalAmount,
                responseMessage: 'Transaction Declined',
                transactionID: sTransactionID ??
                    ((value.isEmpty || value.split('-').isEmpty)
                        ? ''
                        : value.split('-')[1]));
        debugPrint(
            "mUpdatePaymentStatusRequest ${jsonEncode(mUpdatePaymentStatusRequest)}");
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUpdatePaymentStatus(mUpdatePaymentStatusRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          AppAlertBase.showCustomDialogOk(
              Get.context!, sPaymentDeclined.tr, sPaymentDeclinedMessage.tr,
              () {
            onRefresh();
          }, rightText: 'Ok');
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



  ///payment type
  ///senang-Pay
  void senangPayNow(OrderHistoryResponseItemData mOrderHistoryResponse,
      PaymentTypeResponseData mPaymentResponses) async {
    UserDetailsResponseData mUserDetailsResponseData =
        await SharedPrefs().getUserDetails();
    final SenangPayService senangPayService = SenangPayService(
      merchantId: mPaymentResponses.productionConfigurations?.merchantID ??
          '761173165749545',
      // Replace with live Merchant ID
      secretKey:
          mPaymentResponses.productionConfigurations?.secretKey ?? '43106-268',
    );
    var value = await senangPayService.startPayment(
        name:
            '${mUserDetailsResponseData.firstName ?? ''} ${mUserDetailsResponseData.lastName ?? ''}'
                .trim(),
        email: mUserDetailsResponseData.email ?? '',
        phone: mUserDetailsResponseData.phoneNumber ?? '',
        amount: mOrderHistoryResponse.totalAmount ?? 0.0,
        // Payment amount
        orderId: mOrderHistoryResponse.orderIDP ?? '',
        // Unique order ID
        description: '-',
        mRouteConstants: RouteConstants.rSenangPayPaymentScreen);
    if (value.isNotEmpty) {
      bFlagLoad.value = false;
      if (value.toString().toUpperCase().contains('declined'.toUpperCase()) ||
          value.toString().toUpperCase() == 'null'.toUpperCase()) {
        if (value.toString().toUpperCase().contains('declined'.toUpperCase())) {
          await getUpdatePaymentDeclinedApi(mOrderHistoryResponse, value);
        } else {
          AppAlertBase.showCustomDialogOk(Get.context!, sPaymentDeclined.tr,
              sPaymentDeclinedMessage.tr, () {},
              rightText: 'Ok');
        }
      } else if (value
          .toString()
          .toUpperCase()
          .contains('successful'.toUpperCase())) {
        await getUpdatePaymentStatusApi(mOrderHistoryResponse, value);
      }
    }
  }

  ///razer-Pay
  void razerPayNow(OrderHistoryResponseItemData mOrderHistoryResponse,
      PaymentTypeResponseData mPaymentResponses) async {
    UserDetailsResponseData mUserDetailsResponseData =
        await SharedPrefs().getUserDetails();
    RazerPayService paymentService = RazerPayService();
    RazerPayService.value = '';
    try {
      await paymentService.razerPaymentMs(
          (mOrderHistoryResponse.totalAmount ?? 0.0).toString(),
          mOrderHistoryResponse.orderIDP ?? '',
          '${mUserDetailsResponseData.firstName ?? ''} ${mUserDetailsResponseData.lastName ?? ''}'
              .trim(),
          mUserDetailsResponseData.email ?? '',
          mUserDetailsResponseData.phoneNumber ?? '',
          Get.context!,
          sandboxMode: true);

      var value = RazerPayService.value;
      // AppAlertBase.showSnackBar(Get.context!, value);
      RazerResponse mRazerResponse = RazerResponse.fromJson(jsonDecode(value));
      if (mRazerResponse.channel!.trim().isEmpty) {
        await getUpdatePaymentDeclinedApi(mOrderHistoryResponse, value,
            sTransactionID: mRazerResponse.txnID.toString());
      } else {
        await getUpdatePaymentStatusApi(mOrderHistoryResponse, value,
            sTransactionID: mRazerResponse.txnID.toString());
      }
      // AppAlertBase.showSnackBar(Get.context!, value);
    } catch (e) {
      AppAlertBase.showSnackBar(Get.context!, e.toString());
    }
  }
}

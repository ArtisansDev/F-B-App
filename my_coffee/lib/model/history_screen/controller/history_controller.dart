import 'dart:convert';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/add_cart/add_cart.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_request.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../../data/mode/get_item_details/get_item_details_request.dart';
import '../../../data/mode/get_item_details/get_item_details_response.dart';
import '../../../data/mode/get_order_history/get_order_history_request.dart';
import '../../../data/mode/get_order_history/order_history_response.dart';
import '../../../data/mode/order_place/order_place_request.dart';
import '../../../data/mode/senang_pay_payment/senang_pay_service.dart';
import '../../../data/mode/user_details/user_details_response.dart';
import '../../../data/remote/api_call/order/order_api.dart';
import '../../../data/remote/api_call/product_api/product_api.dart';
import '../../../data/remote/web_response.dart';
import '../../../locator.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/date_format.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/num_utils.dart';
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

  ///getOrderPlaceApi
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
          }
          showValue.value = '';
          enablePullUp.value = mOrderHistoryResponseItemData.value.length <
              (mOrderHistoryResponse.data?.totalRecords ?? 0);
          mOrderHistoryResponseItemData.refresh();
        } else {
          showValue.value = 'Internal server error';
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        showValue.value = MessageConstants.noInternetConnection;
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;

  void gotoOrderHistoryDetails(int index) async {
    ///get data
    OrderHistoryResponseItemData mOrderHistoryResponse =
        mOrderHistoryResponseItemData.value[index];
    AppAlert.showProgressDialog(Get.context!);
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
    AppAlert.hideLoadingDialog(Get.context!);
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
        WebResponseSuccess mWebResponseSuccess = await productApi.postGetAllBranchesByRestaurantID(
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
          AppAlert.showSnackBar(
              Get.context!, 'Sorry Restaurant Branches Not found');
        }
      } else {
        AppAlert.showSnackBar(
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
        WebResponseSuccess mWebResponseSuccess = await productApi.postGetItemDetails(mGetItemDetailsRequest, isLoading: false);
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
          // AppAlert.showSnackBar(
          //     Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  void payNow() async{

    final SenangPayService senangPayService = SenangPayService(
      merchantId: '761173165749545', // Replace with live Merchant ID
      secretKey: '43106-268',   // Replace with live Secret Key
    );
    await senangPayService.startPayment(
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '0123456789',
      amount: 500.00, // Payment amount
      orderId: 'order_001', // Unique order ID
      description: 'Product Description',
    );
  }
}

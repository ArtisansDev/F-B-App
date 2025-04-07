import 'dart:async';
import 'dart:convert';

import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_request.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/data/remote/api_call/product_api/product_api.dart';
import 'package:f_b_base/utils/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:web_qr_code_scan/alert/app_alert.dart';
import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_best_seller_item/get_best_seller_item_request.dart';
import 'package:f_b_base/data/mode/get_best_seller_item/get_best_seller_item_response.dart';
import 'package:f_b_base/data/mode/get_dashboard/get_dashboard_request.dart';
import 'package:f_b_base/data/mode/get_dashboard/get_dashboard_response.dart';
import 'package:f_b_base/data/remote/api_call/general_api/general_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../alert/app_alert.dart';
import '../../../routes/route_constants.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../details_page/controller/details_page_controller.dart';
import '../../location_list_screen/controller/location_list_controller.dart';

class HomeScreenController extends GetxController {
  void onChangePage(int value) {}

  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Timer? _timer;
  RxInt currentPage = 0.obs;
  final _kDuration = const Duration(milliseconds: 350);
  final _kCurve = Curves.easeIn;
  Rx<PageController> introductionPageController =
      PageController(initialPage: 0).obs;

  Rx<bool> bFocusGained = true.obs;
  final localApi = locator.get<GeneralApi>();

  isTimerSt() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (mBannerMaster.value.isNotEmpty && bFocusGained.value) {
        if (currentPage < mBannerMaster.value.length - 1) {
          currentPage.value++;
        } else {
          currentPage.value = 0;
        }
        introductionPageController.value.animateToPage(
          currentPage.value,
          duration: _kDuration,
          curve: _kCurve,
        );
      }
    });
  }

  @override
  void dispose() {
    bFocusGained.value = false;
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void selectItem(int index) async {
    String sItemId = dataGetBestSellerItemData[index].menuItemIDP ?? '';
    await Get.toNamed(RouteConstants.rDetailsPageScreen, arguments: sItemId);
    if (Get.isRegistered<DetailsPageScreenController>()) {
      Get.delete<DetailsPageScreenController>();
    }
  }

  late DashboardScreenController controller;

  showDialogPicDine(String title) async {
    if (title == "Dine" &&
        mDashboardScreenController
                .selectGetAllBranchesListData.value.branchIDP !=
            null) {
      if (!(mDashboardScreenController
              .selectGetAllBranchesListData.value.dineIn ??
          false)) {
        AppAlertBase.showSnackBar(
            Get.context!, 'You can\'t able to select Dine in for this branch');
        return;
      }
      // else {
      //   AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
      //   mAddCartModel.sType = 'Dine';
      //   await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
      // }
    } else if (title == "Take" &&
        mDashboardScreenController
                .selectGetAllBranchesListData.value.branchIDP !=
            null) {
      if (!(mDashboardScreenController
              .selectGetAllBranchesListData.value.takeaway ??
          false)) {
        AppAlertBase.showSnackBar(Get.context!,
            'You can\'t able to select Take away in for this branch');
        return;
      }
      // else {
      //   AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
      //   mAddCartModel.sType = 'Take';
      //   await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
      // }
    }

    if (Get.isRegistered<DashboardScreenController>()) {
      controller = Get.find<DashboardScreenController>();
      controller.openDialog(title);
    }
  }

  RxList<GetBestSellerItemData> dataGetBestSellerItemData =
      <GetBestSellerItemData>[].obs;

  // void getBestSellerItemApi() {
  //   NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
  //     if (isInternetAvailable) {
  //       GetBestSellerItemRequest mGetBestSellerItemRequest =
  //           GetBestSellerItemRequest(
  //               branchIDF: "00000000-0000-0000-0000-000000000000",
  //               restaurantIDF:
  //                   (await SharedPrefs().getGeneralSetting()).restaurantIDF ??
  //                       '');
  //       WebResponseSuccess mWebResponseSuccess =
  //           await localApi.postGetBestSellerItem(mGetBestSellerItemRequest);
  //       if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
  //         GetBestSellerItemResponse mGetBestSellerItemResponse =
  //             mWebResponseSuccess.data;
  //         dataGetBestSellerItemData.value.clear();
  //         dataGetBestSellerItemData.value
  //             .addAll(mGetBestSellerItemResponse.data ?? []);
  //         dataGetBestSellerItemData.refresh();
  //       } else {
  //         AppAlertBase.showSnackBar(
  //             Get.context!, mWebResponseSuccess.statusMessage ?? '');
  //       }
  //     } else {
  //       AppAlertBase.showSnackBar(
  //           Get.context!, MessageConstants.noInternetConnection);
  //     }
  //   });
  // }

  RxList<BannerMaster> mBannerMaster = <BannerMaster>[].obs;
  Rxn<GetDashboardResponse> mGetDashboardResponse = Rxn<GetDashboardResponse>();

  void detDashboardDetailsApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetDashboardRequest mGetDashboardRequest = GetDashboardRequest(
            totalRecord: '10',
            restaurantIDF:
                (await SharedPrefs().getGeneralSetting()).restaurantIDF ?? '');
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGetDashboard(mGetDashboardRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          mGetDashboardResponse.value = mWebResponseSuccess.data;
          dataGetBestSellerItemData.value.clear();
          dataGetBestSellerItemData.value.addAll(mGetDashboardResponse
                  .value?.mGetDashboardData?.bestSellingItems ??
              []);
          dataGetBestSellerItemData.refresh();

          mBannerMaster.value.clear();
          mBannerMaster.value.addAll(
              mGetDashboardResponse.value?.mGetDashboardData?.bannerMaster ??
                  []);
          mBannerMaster.refresh();
          stopTimer();
          if (mBannerMaster.value.length > 1) {
            isTimerSt();
          }
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

  ///changeLocation
  changeLocation() async {
    if (!kIsWeb) {
      AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
      if ((mAddCartModel.mItems ?? []).isNotEmpty ||
          (mAddCartModel.sTableNo ?? '').isNotEmpty) {
        AppAlertBase.showCustomDialogYesNoLogout(
            Get.context!,
            'Proceed to Change?',
            'This action will clear the items in your current basket. Do you want to proceed?',
            () async {
          await SharedPrefs().setAddCartData('');
          final selectLocation =
              await AppAlert.showCustomDialogLocationPicker(Get.context!);
          Get.delete<LocationListScreenController>();
          if (selectLocation.isNotEmpty) {
            await SharedPrefs().setAddCartData('');
            detDashboardDetailsApi();
            getOrderDetails();
          }
        }, rightText: 'Ok');
      } else {
        final selectLocation =
            await AppAlert.showCustomDialogLocationPicker(Get.context!);
        Get.delete<LocationListScreenController>();
        if (selectLocation.isNotEmpty) {
          detDashboardDetailsApi();
          getOrderDetails();
        }
      }
    }
  }

  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;

  void getOrderDetails() async {
    mAddCartModel.value = await SharedPrefs().getAddCartData();
    mAddCartModel.refresh();
  }

  ///mGetAllBranchesListData
  RxList<GetAllBranchesListData> mGetAllBranchesListData =
      <GetAllBranchesListData>[].obs;

  void getGetAllBranchesApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetAllBranchesByRestaurantIdRequest
            mGetAllBranchesByRestaurantIdRequest =
            GetAllBranchesByRestaurantIdRequest(
                rowsPerPage: 4,
                pageNumber: 1,
                searchValue: '',
                branchIDP: '',
                todayDate: toDayDate(),
                restaurantIDF:
                    (await SharedPrefs().getGeneralSetting()).restaurantIDF ??
                        '');
        final localApi = locator.get<ProductApi>();
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGetAllBranchesByRestaurantID(
                mGetAllBranchesByRestaurantIdRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetAllBranchesByRestaurantIdResponse
              mGetAllBranchesByRestaurantIdResponse = mWebResponseSuccess.data;
          mGetAllBranchesListData.clear();
          mGetAllBranchesListData
              .addAll(mGetAllBranchesByRestaurantIdResponse.data?.data ?? []);
          mGetAllBranchesListData.refresh();
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

  ///onRefresh
  void onRefresh() async {
    detDashboardDetailsApi();
    if (!kIsWeb) {
      getGetAllBranchesApi();
    }
  }
}

import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/get_category_item/get_category_item_response.dart';
import 'package:f_b_base/data/mode/menu_items/menu_items_request.dart';
import 'package:f_b_base/data/mode/menu_items/menu_items_response.dart';
import 'package:f_b_base/data/mode/register/register_request.dart';
import 'package:f_b_base/data/mode/register/register_response.dart';
import 'package:f_b_base/data/remote/api_call/product_api/product_api.dart';
import 'package:f_b_base/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/get_user_details.dart';
import '../../../routes/route_constants.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../details_page/controller/details_page_controller.dart';
import '../../login_screen/controller/login_controller.dart';
import '../../menu_screen/controller/menu_controller.dart';

class SearchMenuScreenController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  MenuScreenController mMenuScreenController = Get.find<MenuScreenController>();

  Rx<TextEditingController> searchController = TextEditingController().obs;

  final localApi = locator.get<ProductApi>();

  SearchMenuScreenController() {
    onRefresh();
  }

  ///GetCategoryItemListData
  RxList<GetCategoryItemListData> mGetCategoryItemListData =
      <GetCategoryItemListData>[].obs;
  int pageNumber = 1;

  ///Refresh
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool enablePullUp = false.obs;
  RxString mGetCategoryItemMessage = 'Loading...'.obs;

  void onRefresh() async {
    mGetCategoryItemMessage = 'Loading...'.obs;
    mGetCategoryItemListData.clear();
    pageNumber = 1;
    getGetAllItemApi();
  }

  void onLoadMore() async {
    pageNumber = pageNumber + 1;
    getGetAllItemApi();
  }

  void getGetAllItemApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        MenuItemsRequest mMenuItemsRequest = MenuItemsRequest(
            rowsPerPage: 10,
            pageNumber: pageNumber,
            searchValue: searchController.value.text.isEmpty
                ? null
                : searchController.value.text,
            branchIDF: mDashboardScreenController
                .selectGetAllBranchesListData.value.branchIDP,
            restaurantIDF:
                (await SharedPrefs().getGeneralSetting()).restaurantIDF ?? '');
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGetMenuItems(mMenuItemsRequest);
        if (refreshController.isRefresh) {
          refreshController.refreshCompleted();
        } else if (refreshController.isLoading) {
          refreshController.loadComplete();
        }
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          MenuItemsResponse mMenuItemsResponse = mWebResponseSuccess.data;

          mGetCategoryItemListData.addAll(mMenuItemsResponse.data?.data ?? []);
          enablePullUp.value = mGetCategoryItemListData.length <
              (mMenuItemsResponse.data?.totalRecords ?? 0);

          if (mGetCategoryItemListData.length > 0) {
            mGetCategoryItemMessage.value = "";
            mGetCategoryItemMessage.refresh();
          } else {
            mGetCategoryItemMessage.value = "No item found";
            mGetCategoryItemMessage.refresh();
          }

          mGetCategoryItemListData.refresh();
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode500) {
          mGetCategoryItemMessage.value = "No item found";
          mGetCategoryItemMessage.refresh();
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode404) {
          mGetCategoryItemMessage.value = "No item found";
          mGetCategoryItemMessage.refresh();
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


  void selectItem(int index) async {
    String sItemId = mGetCategoryItemListData[index].menuItemIDP ?? '';
    Get.back(result: sItemId);
  //   String sItemId = mGetCategoryItemListData[index].menuItemIDP ?? '';
  //   await Get.toNamed(RouteConstants.rDetailsPageScreen, arguments: sItemId);
  //   if (Get.isRegistered<DetailsPageScreenController>()) {
  //     Get.delete<DetailsPageScreenController>();
  //   }
  }
}

import 'package:my_coffee/alert/app_alert.dart';
import 'package:my_coffee/alert/app_alert_base.dart';
import 'package:my_coffee/constants/message_constants.dart';
import 'package:my_coffee/constants/web_constants.dart';
import 'package:my_coffee/data/local/shared_prefs/shared_prefs.dart';
import 'package:my_coffee/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_request.dart';
import 'package:my_coffee/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:my_coffee/data/remote/api_call/product_api/product_api.dart';
import 'package:my_coffee/data/remote/web_response.dart';
import 'package:my_coffee/locator.dart';
import 'package:my_coffee/utils/date_format.dart';
import 'package:my_coffee/utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class LocationListScreenController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  final localApi = locator.get<ProductApi>();

  LocationListScreenController() {
    onRefresh();
  }

  ///mGetAllBranchesListData
  RxList<GetAllBranchesListData> mGetAllBranchesListData =
      <GetAllBranchesListData>[].obs;
  int pageNumber = 1;

  // RxString searchValue = ''.obs;

  ///Refresh
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool enablePullUp = false.obs;

  void onRefresh() async {
    mGetAllBranchesListData.value.clear();
    pageNumber = 1;
    getGetAllBranchesApi();
  }

  void onLoadMore() async {
    pageNumber = pageNumber + 1;
    getGetAllBranchesApi();
  }

  void getGetAllBranchesApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetAllBranchesByRestaurantIdRequest
            mGetAllBranchesByRestaurantIdRequest =
            GetAllBranchesByRestaurantIdRequest(
                rowsPerPage: 10,
                pageNumber: pageNumber,
                searchValue: searchController.value.text,
                todayDate: toDayDate(),
                restaurantIDF:
                    (await SharedPrefs().getGeneralSetting()).restaurantIDF ??
                        '');
        WebResponseSuccess mWebResponseSuccess = await localApi.postGetAllBranchesByRestaurantID(
                mGetAllBranchesByRestaurantIdRequest);
        if (refreshController.isRefresh) {
          refreshController.refreshCompleted();
        } else if (refreshController.isLoading) {
          refreshController.loadComplete();
        }
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetAllBranchesByRestaurantIdResponse
              mGetAllBranchesByRestaurantIdResponse = mWebResponseSuccess.data;

          mGetAllBranchesListData.value
              .addAll(mGetAllBranchesByRestaurantIdResponse.data?.data ?? []);

          enablePullUp.value = mGetAllBranchesListData.value.length <
              (mGetAllBranchesByRestaurantIdResponse.data?.totalRecords ?? 0);
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
}

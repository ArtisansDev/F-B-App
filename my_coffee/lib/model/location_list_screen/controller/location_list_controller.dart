import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/message_constants.dart';
import '../../../constants/web_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_request.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../utils/date_format.dart';
import '../../../utils/network_utils.dart';

class LocationListScreenController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;

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
    getBestSellerItemApi();
  }

  void onLoadMore() async {
    pageNumber = pageNumber + 1;
    getBestSellerItemApi();
  }

  void getBestSellerItemApi() {
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
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postGetAllBranchesByRestaurantID(
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

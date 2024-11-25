import 'package:f_b_base/alert/app_alert.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_category/get_category_request.dart';
import 'package:f_b_base/data/mode/get_category/get_category_response.dart';
import 'package:f_b_base/data/mode/get_category_item/get_category_item_request.dart';
import 'package:f_b_base/data/mode/get_category_item/get_category_item_response.dart';
import 'package:f_b_base/data/remote/api_call/product_api/product_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../alert/app_alert.dart';
import '../../../routes/route_constants.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../location_list_screen/controller/location_list_controller.dart';

class MenuScreenController extends GetxController {
  RxInt selectSideMenu = 0.obs;

  ///Menu
  final Rx<ItemScrollController> itemScrollControllerMenu =
      ItemScrollController().obs;
  final Rx<ScrollOffsetController> scrollOffsetControllerMenu =
      ScrollOffsetController().obs;
  final Rx<ItemPositionsListener> itemPositionsListenerMenu =
      ItemPositionsListener.create().obs;
  final Rx<ScrollOffsetListener> scrollOffsetListenerMenu =
      ScrollOffsetListener.create().obs;

  ///
  final Rx<ItemScrollController> itemScrollController =
      ItemScrollController().obs;
  final Rx<ScrollOffsetController> scrollOffsetController =
      ScrollOffsetController().obs;
  final Rx<ItemPositionsListener> itemPositionsListener =
      ItemPositionsListener.create().obs;
  final Rx<ScrollOffsetListener> scrollOffsetListener =
      ScrollOffsetListener.create().obs;
  final localApi = locator.get<ProductApi>();

  MenuScreenController() {
    // itemPositionsListener.value.itemPositions.addListener(() {
    //  // selectItem(itemPositionsListener.value.itemPositions.value.single.index);
    // });
    selectSideMenu.value = 0;
    getCategoryApi();
  }

  // RxInt itemCount = 20.obs;
  RxBool val = false.obs;

  void selectMenu(int index) {
    if (selectSideMenu.value != index) {
      mGetCategoryItemMessage.value = 'Loading...';
      mGetCategoryItemListData.value.clear();
      mGetCategoryItemListData.refresh();
      pageNumber = 1;
      selectSideMenu.value = index;
      getCategoryItemApi();
    }
    //   itemScrollController.value.scrollTo(
    //       index: index,
    //       duration: const Duration(seconds: 1),
    //       curve: Curves.easeInOutCubic);
    //   if (index < itemCount.value - 6) {
    //     itemScrollControllerMenu.value.scrollTo(
    //         index: index,
    //         duration: const Duration(seconds: 1),
    //         curve: Curves.easeInOutCubic);
    //   }
  }

  void selectItem(int index) {
    // selectSideMenu.value = index;
    // if (index < itemCount.value - 6) {
    //   itemScrollControllerMenu.value.scrollTo(
    //       index: index,
    //       duration: const Duration(seconds: 1),
    //       curve: Curves.easeInOutCubic);
    // }
    String sItemId = mGetCategoryItemListData[index].menuItemIDP ?? '';
    Get.toNamed(RouteConstants.rDetailsPageScreen, arguments: sItemId);
  }

  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  changeLocation() async {
    AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
    if ((mAddCartModel.mItems ?? []).isNotEmpty) {
      AppAlertBase.showCustomDialogYesNoLogout(Get.context!, 'Proceed to Change?',
          'This action will clear the items in your current basket. Do you want to proceed?',
          () async {
        callLocation();
      }, rightText: 'Ok');
    } else {
      callLocation();
    }
  }

  callLocation() async {
    final selectLocation =
        await AppAlert.showCustomDialogLocationPicker(Get.context!);
    Get.delete<LocationListScreenController>();
    if (selectLocation.isNotEmpty) {
      await SharedPrefs().setAddCartData('');
      selectSideMenu.value = 0;
      mGetCategoryListData.value.clear();
      mGetCategoryItemMessage.value = 'Loading...';
      mGetCategoryItemListData.value.clear();
      mGetCategoryListData.refresh();
      mGetCategoryItemListData.refresh();
      getCategoryApi();
      getOrderDetails();
    }
  }

  ///* GetCategory
  RxList<GetCategoryListData> mGetCategoryListData =
      <GetCategoryListData>[].obs;

  void getCategoryApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetCategoryRequest mGetCategoryRequest = GetCategoryRequest(
          rowsPerPage: 0,
          pageNumber: 1,
          branchIDF: mDashboardScreenController
              .selectGetAllBranchesListData.value.branchIDP,
        );
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGetCategory(mGetCategoryRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetCategoryResponse mGetCategoryResponse = mWebResponseSuccess.data;
          mGetCategoryListData.value.clear();
          mGetCategoryListData.value
              .addAll(mGetCategoryResponse.data?.data ?? []);
          mGetCategoryListData.refresh();
          if (mGetCategoryItemListData.value.isEmpty) {
            getCategoryItemApi();
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

  ///* GetCategoryItem
  RxList<GetCategoryItemListData> mGetCategoryItemListData =
      <GetCategoryItemListData>[].obs;
  RxString mGetCategoryItemMessage = 'Loading...'.obs;

  void getCategoryItemApi() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetCategoryItemRequest mGetCategoryItemRequest = GetCategoryItemRequest(
            rowsPerPage: 10,
            pageNumber: pageNumber,
            branchIDF: mDashboardScreenController
                .selectGetAllBranchesListData.value.branchIDP,
            categoryIDF:
                mGetCategoryListData.value[selectSideMenu.value].categoryIDP);
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGetCategoryItem(mGetCategoryItemRequest);
        if (refreshController.isRefresh) {
          refreshController.refreshCompleted();
        } else if (refreshController.isLoading) {
          refreshController.loadComplete();
        }
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetCategoryItemResponse mGetCategoryItemResponse =
              mWebResponseSuccess.data;
          mGetCategoryItemListData.value
              .addAll(mGetCategoryItemResponse.data?.data ?? []);
          enablePullUp.value = mGetCategoryItemListData.value.length <
              (mGetCategoryItemResponse.data?.totalRecords ?? 0);
          mGetCategoryItemMessage.value = mGetCategoryListData.value.isEmpty
              ? 'No Item found for this category'
              : "";
          mGetCategoryListData.refresh();
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

  ///Refresh
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool enablePullUp = false.obs;
  int pageNumber = 1;

  void onRefresh() async {
    mGetCategoryItemListData.value.clear();
    pageNumber = 1;
    getCategoryItemApi();
  }

  void onLoadMore() async {
    pageNumber = pageNumber + 1;
    getCategoryItemApi();
  }

  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;

  void getOrderDetails() async {
    mAddCartModel.value = await SharedPrefs().getAddCartData();
    mAddCartModel.refresh();
  }
}

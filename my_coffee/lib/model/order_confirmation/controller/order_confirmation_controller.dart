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

  OrderConfirmationScreenController() {
    getOrderDetails();
  }

  checkLoginStatus() async {
    String sLoginStatus = await SharedPrefs().getUserToken();
    return sLoginStatus.isEmpty;
  }

  orderNow() async {
    if (await checkLoginStatus()) {
      Get.toNamed(RouteConstants.rLoginScreen);
    }
  }

  ///setLocation
  Rx<GetAllBranchesListData> selectGetAllBranchesListData =
      GetAllBranchesListData().obs;

  ///getStoreLocation
  void getStoreLocation() {
    selectGetAllBranchesListData.value =
        mDashboardScreenController.selectGetAllBranchesListData.value;
  }

  ///select Date Time
  void selectDateAndTime() {}

  void getOrderDetails() async {
    mAddCartModel.value = await SharedPrefs().getAddCartData();
    selectGetAllBranchesListData.value =
        mAddCartModel.value.mGetAllBranchesListData ?? GetAllBranchesListData();
    totalAmount.value = mAddCartModel.value.totalAmount ?? 0.0;
    mItems.clear();
    mItems.addAll((mAddCartModel.value.mItems ?? []).toList());
    for (GetItemDetailsData mGetItemDetailsData in mItems) {
      totalCountItem.value =
          totalCountItem.value + (mGetItemDetailsData.count ?? 0);
    }

    mAddCartModel.refresh();
  }

  ///
  void priceIncDec(
      GetItemDetailsData mGetItemDetailsData, int index, int count) {
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
  }
}

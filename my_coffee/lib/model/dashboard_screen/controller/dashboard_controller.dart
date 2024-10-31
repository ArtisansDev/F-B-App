import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:my_coffee/model/history_screen/view/history_screen.dart';
import 'package:my_coffee/model/more_screen/view/more_screen.dart';
import 'package:my_coffee/model/profile_screen/view/profile_screen.dart';

import '../../../alert/app_alert.dart';
import '../../../constants/get_user_details.dart';
import '../../../constants/logout_expired.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/add_cart/add_cart.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../../lang/translation_service_key.dart';
import '../../../routes/route_constants.dart';
import '../../history_screen/controller/history_controller.dart';
import '../../home_screen/controller/home_controller.dart';
import '../../home_screen/view/home_screen.dart';
import '../../location_list_screen/controller/location_list_controller.dart';
import '../../menu_screen/controller/menu_controller.dart';
import '../../menu_screen/view/menu_screen.dart';
import '../../more_screen/controller/more_controller.dart';
import '../../profile_screen/controller/profile_controller.dart';
import '../../shopping_card_screen/controller/shoping_screen_controller.dart';

class DashboardScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;

  DashboardScreenController() {
    setSelectLocation();
  }

  void onItemTapped(int value) async {
    if (selectedIndex.value != value) {
      if (value > 1 && await checkLoginStatus()) {
        openLoginView();
        return;
      }
      if (value == 1) {
        var value = await showDialogPicDine();
        if (value == null) {
          return;
        }
        String selectLocation = await showDialogPicDineLocation(value);
        if (selectLocation.isEmpty) {
          return;
        }
      }
      if (value != 4) {
        if (Get.isRegistered<MoreScreenController>()) {
          Get.find<MoreScreenController>().dispose();
          Get.delete<MoreScreenController>();
        }
      }
      if (value != 3) {
        if (Get.isRegistered<ProfileScreenController>()) {
          Get.find<ProfileScreenController>().dispose();
          Get.delete<ProfileScreenController>();
        }
      }
      if (value != 2) {
        if (Get.isRegistered<HistoryScreenController>()) {
          Get.find<HistoryScreenController>().dispose();
          Get.delete<HistoryScreenController>();
        }
      }
      if (value != 1) {
        if (Get.isRegistered<MenuScreenController>()) {
          Get.find<MenuScreenController>().dispose();
          Get.delete<MenuScreenController>();
        }
      }
      if (value != 0) {
        if (Get.isRegistered<HomeScreenController>()) {
          Get.find<HomeScreenController>().dispose();
          Get.delete<HomeScreenController>();
        }
        if (Get.isRegistered<ShoppingScreenController>()) {
          Get.find<ShoppingScreenController>().dispose();
          Get.delete<ShoppingScreenController>();
        }
      }
      selectedIndex.value = value;
      selectTitle(value);
    }
  }

  checkLoginStatus() async {
    String sLoginStatus = await SharedPrefs().getUserToken();
    return sLoginStatus.isEmpty;
  }

  openLoginView() async {
    Get.toNamed(RouteConstants.rLoginScreen);
  }

  List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const MenuScreen(),
    const HistoryScreen(),
    const MoreScreen(),
    const ProfileScreen(),
  ];
  RxString sDialogPicDine = ''.obs;

  openDialog(String title) async {
    String selectLocation = await showDialogPicDineLocation(title);
    if (selectLocation.isEmpty) {
      return;
    } else {
      selectedIndex.value = 1;
      selectTitle(1);
    }
  }

  ///setLocation
  Rx<GetAllBranchesListData> selectGetAllBranchesListData =
      GetAllBranchesListData().obs;

  setSelectLocation() async {
    selectGetAllBranchesListData.value = await SharedPrefs().getBranchesData();
  }

  void setLocation(GetAllBranchesListData mGetAllBranchesListData) async {
    selectGetAllBranchesListData.value = mGetAllBranchesListData;
    await SharedPrefs().setBranchesData(jsonEncode(mGetAllBranchesListData));
    Get.back(result: 'selected');
  }

  showDialogPicDineLocation(String title) async {
    sDialogPicDine.value = title;
    var selectLocation = '';
    if (sDialogPicDine.value == 'Dine') {
    } else if (sDialogPicDine.value == 'Take') {
      if ((selectGetAllBranchesListData.value.branchName ?? '').isEmpty) {
        AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
        if ((mAddCartModel.mItems ?? []).isNotEmpty) {
          AppAlert.showCustomDialogYesNoLogout(
              Get.context!,
              'Proceed to Change?',
              'This action will clear the items in your current basket. Do you want to proceed?',
              () async {
            await SharedPrefs().setAddCartData('');
            selectLocation =
                await AppAlert.showCustomDialogLocationPicker(Get.context!);
            Get.delete<LocationListScreenController>();
          }, rightText: 'Ok');
        } else {
          selectLocation =
              await AppAlert.showCustomDialogLocationPicker(Get.context!);
          Get.delete<LocationListScreenController>();
        }
      } else {
        selectedIndex.value = 1;
      }
    }
    return selectLocation;
  }

  showDialogPicDine() async {
    var value = await AppAlert.showCustomDialogPicDine(Get.context!);
    return value;
  }

  ///Title top bar
  RxString sTitle = sAppName.tr.obs;

  void selectTitle(int value) {
    switch (value) {
      case 0:
        sTitle.value = sAppName.tr;
        return;
      case 1:
        sTitle.value = sMenu.tr;
        return;
      case 2:
        sTitle.value = sGiftCard.tr;
        return;
      case 3:
        sTitle.value = sRewards.tr;
        return;
      case 4:
        sTitle.value = sAccount.tr;
        return;
    }
  }
}

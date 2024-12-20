import 'dart:convert';

import 'package:my_coffee/alert/app_alert.dart';
import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_coffee/model/profile_screen/view/profile_screen.dart';


import '../../../routes/route_constants.dart';
import '../../history_screen/view/history_screen.dart';
import '../../home_screen/controller/home_controller.dart';
import '../../home_screen/view/home_screen.dart';
import '../../location_list_screen/controller/location_list_controller.dart';
import '../../menu_screen/controller/menu_controller.dart';
import '../../menu_screen/view/menu_screen.dart';
import '../../profile_screen/controller/profile_controller.dart';
import '../../qr_code_scanner/controller/qr_code_scanner_controller.dart';
import '../../rewards_screen/controller/rewards_controller.dart';

class DashboardScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxString selectedCurrency = ''.obs;

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

      if (value != 3) {
        if (Get.isRegistered<ProfileScreenController>()) {
          Get.find<ProfileScreenController>().dispose();
          Get.delete<ProfileScreenController>();
        }
      }
      if (value != 2) {
        if (Get.isRegistered<RewardsScreenController>()) {
          Get.find<RewardsScreenController>().dispose();
          Get.delete<RewardsScreenController>();
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
    selectedCurrency.value =
        (selectGetAllBranchesListData.value.currency ?? []).isEmpty
            ? ''
            : (selectGetAllBranchesListData.value.currency ?? [])
                    .first
                    .currencySymbol ??
                '';
  }

  void setLocation(GetAllBranchesListData mGetAllBranchesListData) async {
    selectGetAllBranchesListData.value = mGetAllBranchesListData;
    selectedCurrency.value = (mGetAllBranchesListData.currency ?? []).isEmpty
        ? ''
        : (mGetAllBranchesListData.currency ?? []).first.currencySymbol ?? '';
    await SharedPrefs().setBranchesData(jsonEncode(mGetAllBranchesListData));
    Get.back(result: 'selected');
  }

  Rxn<String> selectTableNo = Rxn<String>();

  void setTable({String? sTableNo}) async {
    selectTableNo.value = sTableNo;
    Get.back(result: 'selected');
  }

  showDialogPicDineLocation(String title) async {
    var selectLocation = '';
    if ((selectGetAllBranchesListData.value.branchName ?? '').isEmpty) {
      await AppAlert.showCustomDialogLocationPicker(Get.context!);
      if (Get.isRegistered<HomeScreenController>()) {
        HomeScreenController mHomeScreenController =
            Get.find<HomeScreenController>();
        mHomeScreenController.detDashboardDetailsApi();
      }
    } else if (await isCheckType(title)) {
      sDialogPicDine.value = title;
      AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
      if (sDialogPicDine.value == 'Dine') {
        if ((mAddCartModel.sTableNo ?? '').isEmpty) {
          selectLocation = await Get.toNamed(
            RouteConstants.rQrCodeScannerView,
          );
          Get.delete<QrCodeScannerController>();
          if (selectLocation.isNotEmpty) {
            selectedIndex.value = 1;
          }
        }else {
          selectedIndex.value = 1;
        }
      } else if (sDialogPicDine.value == 'Take') {
        mAddCartModel.sTableNo = '';
        await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
        if ((selectGetAllBranchesListData.value.branchName ?? '').isEmpty) {
          AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
          if ((mAddCartModel.mItems ?? []).isNotEmpty) {
            AppAlertBase.showCustomDialogYesNoLogout(
                Get.context!,
                'Proceed to Change?',
                'This action will clear the items in your current basket. Do you want to proceed?',
                () async {
              await SharedPrefs().setAddCartData('');
              selectLocation =
                  await AppAlert.showCustomDialogLocationPicker(Get.context!);
              Get.delete<LocationListScreenController>();
              if (selectLocation.isNotEmpty) {
                await SharedPrefs().setAddCartData('');
              }
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
    }
    return selectLocation;
  }

  isCheckType(String title) async {
    AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
    if ((mAddCartModel.sType ?? '').toString().trim().contains(title)) {
      return true;
    } else {
      if ((mAddCartModel.mItems ?? []).isEmpty) {
        await SharedPrefs()
            .setAddCartData(jsonEncode(AddCartModel(sType: title)));
        return true;
      } else {
        AppAlertBase.showCustomDialogYesNoLogout(Get.context!, 'Proceed to Change?',
            'This action will clear the items in your current basket. Do you want to proceed?',
            () async {
          await SharedPrefs()
              .setAddCartData(jsonEncode(AddCartModel(sType: title)));
          if (Get.isRegistered<HomeScreenController>()) {
            HomeScreenController mHomeScreenController =
                Get.find<HomeScreenController>();
            mHomeScreenController.getOrderDetails();
          }

          return true;
        }, rightText: 'Ok');
      }
    }
    return false;
  }

  showDialogPicDine() async {
    var value = await AppAlertBase.showCustomDialogPicDine(Get.context!);
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
        sTitle.value = sHistory.tr;
        return;
      // case 3:
      //   sTitle.value = sRewards.tr;
      //   return;
      case 3:
        sTitle.value = sAccount.tr;
        return;
    }
  }
}

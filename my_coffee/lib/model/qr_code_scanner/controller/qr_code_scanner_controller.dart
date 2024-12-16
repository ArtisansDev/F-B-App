import 'dart:convert';
import 'dart:developer';

import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_request.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/data/mode/get_seat_detail/get_saat_details_request.dart';
import 'package:f_b_base/data/mode/get_seat_detail/get_seat_detail_response.dart';
import 'package:f_b_base/data/remote/api_call/product_api/product_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/date_format.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:my_coffee/alert/app_alert.dart';
import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../location_list_screen/controller/location_list_controller.dart';

class QrCodeScannerController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rxn<Barcode> result = Rxn<Barcode>();
  Rxn<QRViewController> mQRViewController = Rxn<QRViewController>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Rx<TextEditingController> tableNumberController = TextEditingController().obs;

  @override
  void dispose() {
    mQRViewController.value?.dispose();
    super.dispose();
  }

  RxString seatID = ''.obs;

  void onQRViewCreated(QRViewController controller) {
    mQRViewController.value = controller;
    mQRViewController.value?.resumeCamera();

    mQRViewController.value?.scannedDataStream.listen((scanData) {
      result.value = scanData;
      mQRViewController.value?.pauseCamera();

      /// Get the full current URL
      String url = scanData.code ?? '';

      /// http://localhost:54052/#/introduction_screen?table_no=10&BranchIDF=d8254b69-b6e0-4f10-9d61-888a5d2f779e
      if (url.contains('localhost')) {
        if (url.split(':').length > 2) {
          url = url.split(':').first + '://' + url.split(':').last;
        }
      }

      if (url.contains('SeatID')) {
        url = url.replaceAll('#', 'abcd');
        final uri = Uri.parse(url);
        seatID.value = uri.queryParameters['SeatID'].toString();
        getGetSeatDetailApi(seatID.value);
      }
    });
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void selectTable() async {
    if (tableNumberController.value.text.isEmpty) {
      AppAlertBase.showSnackBar(Get.context!, 'Please select the table number');
    } else {
      isCheckTable();
    }
  }

  isCheckTable() async {
    AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
    if ((mAddCartModel.sTableNo ?? '').isNotEmpty &&
        !(mAddCartModel.sTableNo ?? '')
            .toString()
            .trim()
            .contains(tableNumberController.value.text)) {
      AppAlertBase.showCustomDialogYesNoLogout(
          Get.context!,
          'Proceed to Change?',
          'This action will clear the items in your current basket. Do you want to proceed?',
          () async {
        await SharedPrefs().setAddCartData('');
      }, rightText: 'Ok');
      return false;
    } else {
      mAddCartModel.sTableNo = tableNumberController.value.text;
      mAddCartModel.sType = 'Dine';
      await SharedPrefs().setAddCartData(jsonEncode(mAddCartModel));
      mDashboardScreenController.setTable(
          sTableNo: tableNumberController.value.text);
    }
  }

  void changeLocation() async {
    AddCartModel mAddCartModel = await SharedPrefs().getAddCartData();
    if ((mAddCartModel.mItems ?? []).isNotEmpty) {
      AppAlertBase.showCustomDialogYesNoLogout(
          Get.context!,
          'Proceed to Change?',
          'This action will clear the items in your current basket. Do you want to proceed?',
          () async {
        await SharedPrefs().setAddCartData('');
        await AppAlert.showCustomDialogLocationPicker(Get.context!);
        Get.delete<LocationListScreenController>();
      }, rightText: 'Ok');
    } else {
      await AppAlert.showCustomDialogLocationPicker(Get.context!);
      Get.delete<LocationListScreenController>();
    }
  }

  ///api getGetSeatDetailApi
  getGetSeatDetailApi(String seatID) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetSaatDetailsRequest mGetSaatDetailsRequest =
            GetSaatDetailsRequest(seatID: seatID);
        WebResponseSuccess mWebResponseSuccess = await locator
            .get<ProductApi>()
            .postGetSeatDetail(mGetSaatDetailsRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetSeatDetailResponse mGetSeatDetailResponse =
              mWebResponseSuccess.data;
          tableNumberController.value.text =
              mGetSeatDetailResponse.data?.seatNumber ?? '';
          // await SharedPrefs().setAddCartData(jsonEncode(AddCartModel(
          //     sTableNo: mGetSeatDetailResponse.data?.seatNumber??'', sType: 'Dine')));

          await getGetAllBranchesApi(
              mGetSeatDetailResponse.data?.branchIDF ?? '');
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

  ///mGetAllBranchesListData
  RxList<GetAllBranchesListData> mGetAllBranchesListData =
      <GetAllBranchesListData>[].obs;

  getGetAllBranchesApi(String selectBranchIDF) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetAllBranchesByRestaurantIdRequest
            mGetAllBranchesByRestaurantIdRequest =
            GetAllBranchesByRestaurantIdRequest(
                rowsPerPage: 0,
                pageNumber: 1,
                searchValue: '',
                todayDate: toDayDate(),
                restaurantIDF:
                    (await SharedPrefs().getGeneralSetting()).restaurantIDF ??
                        '');
        WebResponseSuccess mWebResponseSuccess = await locator
            .get<ProductApi>()
            .postGetAllBranchesByRestaurantID(
                mGetAllBranchesByRestaurantIdRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetAllBranchesByRestaurantIdResponse
              mGetAllBranchesByRestaurantIdResponse = mWebResponseSuccess.data;
          mGetAllBranchesListData.value.clear();
          mGetAllBranchesListData.value
              .addAll(mGetAllBranchesByRestaurantIdResponse.data?.data ?? []);
          int trendIndex = mGetAllBranchesListData.value.indexWhere(
            (element) {
              return element.branchIDP.toString() == selectBranchIDF;
            },
          );

          if (trendIndex != -1) {
            mDashboardScreenController.selectGetAllBranchesListData.value =
                mGetAllBranchesListData.value[trendIndex];
            await SharedPrefs().setBranchesData(
                jsonEncode(mGetAllBranchesListData.value[trendIndex]));
            mDashboardScreenController.selectGetAllBranchesListData.refresh();
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
}

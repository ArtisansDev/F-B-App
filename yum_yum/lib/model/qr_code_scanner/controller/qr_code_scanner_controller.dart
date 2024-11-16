import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_coffee/alert/app_alert.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/add_cart/add_cart.dart';
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

  void onQRViewCreated(QRViewController controller) {
    mQRViewController.value = controller;
    mQRViewController.value?.resumeCamera();

    mQRViewController.value?.scannedDataStream.listen((scanData) {
      result.value = scanData;
      mQRViewController.value?.pauseCamera();
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
      AppAlert.showSnackBar(Get.context!, 'Please select the table number');
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
      AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Proceed to Change?',
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
      AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Proceed to Change?',
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
}

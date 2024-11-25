// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import '../model/location_list_screen/view/location_list_screen.dart';
import '../model/qr_code_scanner/view/qr_code_scanner_view.dart';

class AppAlert {
  AppAlert._();

  static Future<String> showCustomDialogLocationPicker(
    BuildContext context, {
    bool? barrierDismissible,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LocationListScreen();
      },
      barrierDismissible: barrierDismissible ?? false,
      useSafeArea:
          false, // Optional: Ensures the dialog doesn't overlap the status bar
    );
  }

  static Future<String> showQrcodeScan(
      BuildContext context, {
        bool? barrierDismissible,
      }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const QrCodeScannerView();
      },
      barrierDismissible: barrierDismissible ?? false,
      useSafeArea:
      false, // Optional: Ensures the dialog doesn't overlap the status bar
    );
  }


}


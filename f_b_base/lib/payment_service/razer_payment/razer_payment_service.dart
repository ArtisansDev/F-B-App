/*
 * Project      : razer_payment_demo
 * File         : razer_payment_service.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-12-02
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:convert';

import 'package:fiuu_mobile_xdk_flutter/fiuu_mobile_xdk_flutter.dart';
import 'package:flutter/cupertino.dart';

import '../../alert/app_alert_base.dart';

class RazerPayService {
  static String value = '';

  Future<void> razerPaymentMs(String amount, String orderId, String billName,
      String billEmail, String billMobile,
      BuildContext mBuildContext,
      {bool? sandboxMode = false}) async {
    var paymentDetails = {
      'mp_username': 'RMSxdk_SB',
      'mp_password': 'RmS_Sb!p@s\$wd',
      'mp_merchant_ID': 'SB_ttgreen',
      'mp_app_name': 'SB_ttgreen',
      'mp_verification_key': 'ff160fc47518b2a225551759a6b22379',
      // Mandatory String. Payment values
      'mp_amount': amount,
      'mp_order_ID': orderId,
      'mp_currency': 'MYR',
      'mp_country': 'MY',
      // Optional String.
      'mp_channel': 'multi',
      // Use 'multi' for all available channels option. For individual channel seletion, please refer to "Channel Parameter" in "Channel Lists" in the MOLPay API Spec for Merchant pdf.
      'mp_bill_description': 'Yumyum order',
      'mp_bill_name': billName,
      'mp_bill_email': billEmail,
      'mp_bill_mobile': billMobile,
      'mp_dev_mode': false,
      'mp_sandbox_mode': sandboxMode,
    };
    // AppAlertBase.showSnackBar(mBuildContext, '###${paymentDetails.toString()}');
    String? result = await MobileXDK.start(paymentDetails);
    value = "$result";
    debugPrint(value);
    // AppAlertBase.showSnackBar(mBuildContext, '###${value}');
    if (result != null) {
      Map resultMap = json.decode(result);
      debugPrint("Razer Payment json map : $resultMap ");
    }
  }
}

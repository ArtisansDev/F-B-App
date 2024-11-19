import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/senang_pay_payment/controller/senang_pay_payment_controller.dart';
import '../../../routes/route_constants.dart';

class SenangPayService {
  final String merchantId;
  final String secretKey;

  SenangPayService({
    required this.merchantId,
    required this.secretKey,
  });

  /// Generate SHA256 hash
  String _generateHash(String orderId, String amount) {
    final rawHash = '$orderId|$amount|$secretKey';
    final bytes = utf8.encode(rawHash);
    return sha256.convert(bytes).toString();
  }

  /// Start Payment
  Future<void> startPayment({
    required String name,
    required String email,
    required String phone,
    required double amount,
    required String orderId,
    required String description,
  }) async {
    // Ensure amount is in two decimal places
    final formattedAmount = amount.toStringAsFixed(2);

    // Generate hash
    final hash = _generateHash(orderId, formattedAmount);

    // Construct payment URL
    final paymentUrl = Uri.https(
      'app.senangpay.my',
      '/payment/$merchantId',
      {
        'name': name,
        'email': email,
        'phone': phone,
        'amount': formattedAmount,
        'order_id': orderId,
        'desc': description,
        'hash': hash,
      },
    ).toString();

    debugPrint("url $paymentUrl");

    ///next screen
    await Get.toNamed(RouteConstants.rSenangPayPaymentScreen,
        arguments: paymentUrl);

    if (Get.isRegistered<SenangPayPaymentController>()) {
      Get.delete<SenangPayPaymentController>();
    }

    /// Launch the payment page
    // if (await canLaunch(paymentUrl.toString())) {
    //   await launch(paymentUrl.toString());
    // } else {
    //   throw 'Could not launch $paymentUrl';
    // }
  }
}

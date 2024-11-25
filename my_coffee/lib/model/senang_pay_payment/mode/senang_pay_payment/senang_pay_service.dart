import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/route_constants.dart';
import '../../controller/senang_pay_payment_controller.dart';

class SenangPayService {
  final String merchantId;
  final String secretKey;

  SenangPayService({
    required this.merchantId,
    required this.secretKey,
  });

  /// Generate SHA256 hash
  String _generateHash(String orderId, String amount, String description) {
    final rawHash = '$secretKey$description$amount$orderId';
    Hmac hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
    // Compute the HMAC
    Digest hmacResult = hmacSha256.convert(utf8.encode(rawHash));
    String hmacHex = hmacResult.toString();
    return hmacHex;
  }

  /// Start Payment
  Future<String> startPayment({
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
    final hash = _generateHash(orderId, formattedAmount, description);
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
        'detail': description,
        'hash': hash,
      },
    ).toString();

    ///next screen
    var value = await Get.toNamed(RouteConstants.rSenangPayPaymentScreen,
        arguments: paymentUrl);

    if (Get.isRegistered<SenangPayPaymentController>()) {
      Get.delete<SenangPayPaymentController>();
    }
    return value.toString();

    /// Launch the payment page
    // if (await canLaunch(paymentUrl.toString())) {
    //   await launch(paymentUrl.toString());
    // } else {
    //   throw 'Could not launch $paymentUrl';
    // }
  }
}

String getTransactionId(String url) {
  // The URL
  // String url = "https://app.senangpay.my/result?&status_id=1&order_id=5e0d25ec-e98b-44c9-b951-04a1cd40c57d&transaction_id=1732011800009507219&msg=Payment_was_successful&hash=c149318fd96704782738011d3f76c29dbc3e6b427b36cdccee7e278dac689704";

  // Parse the URL
  Uri uri = Uri.parse(url);

  // Extract the 'transaction_id' query parameter
  String? transactionId = uri.queryParameters['transaction_id'];

  // Print the result
  if (transactionId != null) {
    debugPrint("Transaction ID: $transactionId");
    return transactionId??'';
  } else {
    debugPrint("Transaction ID not found in the URL.");
    return '';
  }
}

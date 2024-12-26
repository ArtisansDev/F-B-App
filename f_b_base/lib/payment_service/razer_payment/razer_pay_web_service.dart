import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RazerPayWebService {
  final String merchantId;
  final String secretKey;

  RazerPayWebService({
    required this.merchantId,
    required this.secretKey,
  });

  /// Generate SHA256 hash
  // String _generateHash(String orderId, String amount, String description) {
  //   final rawHash = '$secretKey$description$amount$orderId';
  //   Hmac hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
  //   // Compute the HMAC
  //   Digest hmacResult = hmacSha256.convert(utf8.encode(rawHash));
  //   String hmacHex = hmacResult.toString();
  //   return hmacHex;
  // }

  /// Generate MD5 Hash
  String _generateMD5(String orderId, String amount, String description) {
    final bytes = utf8.encode(
        amount + merchantId + orderId + secretKey); // Convert string to bytes
    final digest = md5.convert(bytes); // Perform MD5 hash
    return digest.toString(); // Convert
  }

  /// Start Payment
  Future<String> startPayment({
    required String name,
    required String email,
    required String phone,
    required double amount,
    required String orderId,
    required String description,
    required String mRouteConstants,
  }) async {
    // Ensure amount is in two decimal places
    final formattedAmount = amount.toStringAsFixed(2);
    // Generate hash
    final hash = _generateMD5(orderId, formattedAmount, description);
    // Construct payment_service URL
    final paymentUrl = Uri.https(
      // 'pay.fiuu.com',
      // '/RMS/API/Direct/1.4.0/index.php',
      'sandbox.merchant.razer.com',
      '/RMS/pay/$merchantId/index.php',
      {
        // 'name': name,
        // 'email': email,
        // 'phone': phone,
        'amount': formattedAmount,
        'orderid': orderId,
        'cur': 'MYR',
        'bill_desc': description,
        'vcode': hash,
        // "CallbackURL": "https:/xxx.com/callback",
        "ReturnURL": "http://localhost:51745/#/razer_pay_result",
        // "NotificationURL": "http://13.53.89.14:804/?SeatID=7f732f3a-5195-43bc-9964-ddda6ada7e06#/dashboard_screen",
      },
    ).toString();

    ///next screen
    if (kIsWeb) {
      return paymentUrl;
    } else {
      var value = await Get.toNamed(mRouteConstants, arguments: paymentUrl);
      return value.toString();
    }
  }

  launchUrl(String paymentUrl) {}
}

String getTransactionId(String url) {
  // The URL
  // String url = "https://app.senangpay.my/result?&status_id=1&order_id=5e0d25ec-e98b-44c9-b951-04a1cd40c57d&transaction_id=1732011800009507219&msg=Payment_was_successful&hash=c149318fd96704782738011d3f76c29dbc3e6b427b36cdccee7e278dac689704";

  /// Parse the URL
  Uri uri = Uri.parse(url);

  /// Extract the 'transaction_id' query parameter
  String? transactionId = uri.queryParameters['transaction_id'];

  // Print the result
  if (transactionId != null) {
    debugPrint("Transaction ID: $transactionId");
    return transactionId ?? '';
  } else {
    debugPrint("Transaction ID not found in the URL.");
    return '';
  }
}

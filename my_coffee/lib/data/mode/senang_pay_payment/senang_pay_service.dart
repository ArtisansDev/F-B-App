import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
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

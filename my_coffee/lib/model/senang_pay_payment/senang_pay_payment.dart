/*
 * Project      : my_coffee
 * File         : senang_pay_payment.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-14
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../data/mode/senang_pay_payment/senang_pay_payment_model.dart';

class SenangPayPayment extends StatefulWidget {
  const SenangPayPayment({super.key, });
  @override
  _SenangPayPaymentState createState() => _SenangPayPaymentState();
}

class _SenangPayPaymentState extends State<SenangPayPayment> {
  late String hash;
  late String paymentUrl;
  late final WebViewController _controller;
  late SenangPayPaymentModel mSenangPayPaymentModel;

  @override
  void initState() {
    super.initState();
    mSenangPayPaymentModel = Get.arguments;
    print('###### ${jsonEncode(mSenangPayPaymentModel)}');
    /// Generate the hash value for SenangPay
    hash = generateHash(mSenangPayPaymentModel.secretKey??'', mSenangPayPaymentModel.amount??'', mSenangPayPaymentModel.orderId??'');

    /// Build the SenangPay URL with all parameters
    paymentUrl =
        "https://sandbox.senangpay.my/payment/${mSenangPayPaymentModel.merchantId}?amount=${mSenangPayPaymentModel.amount}&order_id=${mSenangPayPaymentModel.orderId}&name=${mSenangPayPaymentModel.name}&email=${mSenangPayPaymentModel.email}&phone=${mSenangPayPaymentModel.phone}&hash=$hash";
 // paymentUrl =
 //        "https://app.senangpay.my/payment/${mSenangPayPaymentModel.merchantId}?amount=${mSenangPayPaymentModel.amount}&order_id=${mSenangPayPaymentModel.orderId}&name=${mSenangPayPaymentModel.name}&email=${mSenangPayPaymentModel.email}&phone=${mSenangPayPaymentModel.phone}&hash=$hash";

    ///#docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    /// #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Check if the payment is completed
            if (request.url.contains("your_redirect_url")) {
              // Handle the payment success or failure based on the URL
              // Navigator.pop(context, true); // Return success
              Get.back();
            }
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {},
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(paymentUrl));

    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(const Color(0x80000000));
    }

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  String generateHash(String secretKey, String amount, String orderId) {
    String toHash = secretKey + amount + orderId;
    return md5.convert(utf8.encode(toHash)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SenangPay Payment"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

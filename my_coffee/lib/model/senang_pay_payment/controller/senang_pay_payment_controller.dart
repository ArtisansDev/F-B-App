// ignore_for_file: depend_on_referenced_packages

import 'package:f_b_base/payment_service/senang_pay_payment/senang_pay_service.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class SenangPayPaymentController extends GetxController {
  RxString paymentUrl = ''.obs;
  Rxn<WebViewController> mWebViewController = Rxn<WebViewController>();

  SenangPayPaymentController(String sUrl) {
    paymentUrl.value = sUrl;
    webController();
  }

  webController() {
    ///docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController mController =
        WebViewController.fromPlatformCreationParams(params);

    /// enddocregion platform_features
    mController
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
            if (request.url.contains("Payment_was_successful")) {
              Get.back(
                  result:
                      'successful - ${getTransactionId(request.url)} - ${request.url}');
            } else if (request.url.contains("The_payment_was_declined.")) {
              Get.back(
                  result:
                      'declined - ${getTransactionId(request.url)} - ${request.url}');
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
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(paymentUrl.value));

    /// setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      mController.setBackgroundColor(const Color(0x80000000));
    }

    /// #docregion platform_features
    if (mController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (mController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    mWebViewController.value = mController;
    mWebViewController.refresh();
  }

// /// Generate SHA256 hash for SenangPay
// String generateHash(String secretKey, String amount, String orderId) {
//   final rawString = '$orderId|$amount|$secretKey';
//   final bytes = utf8.encode(rawString);
//   final hash = sha256.convert(bytes);
//   return hash.toString();
// }
}

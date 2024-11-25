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
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/appbars_common.dart';
import '../../lang/translation_service_key.dart';
import 'controller/senang_pay_payment_controller.dart';

class SenangPayPayment extends GetView<SenangPayPaymentController> {
  late SenangPayPaymentController controller;
  late String sUrl;

  SenangPayPayment({super.key}) {
    sUrl = Get.arguments;
    controller = Get.put<SenangPayPaymentController>(
        SenangPayPaymentController(sUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarsCommon.appBarBack(title: sSenangPayPayment.tr),
        body: FocusDetector(
            onVisibilityGained: () {},
            onVisibilityLost: () {},
            child: Obx(
              () {
                return Visibility(
                    visible: controller.mWebViewController.value != null,
                    child: WebViewWidget(
                        controller: controller.mWebViewController.value!));
              },
            )));
  }
}

/*
 * Project      : my_coffee
 * File         : senang_pay_payment.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-14
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'controller/senang_pay_payment_controller.dart';

class SenangPayPayment extends GetView<SenangPayPaymentController> {
  late SenangPayPaymentController controller;
  late String sUrl;

  SenangPayPayment({super.key}) {
    sUrl = Get.arguments;
    controller =
        Get.put<SenangPayPaymentController>(SenangPayPaymentController(sUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarsCommon.appBarBackPayment(title: sSenangPayPayment.tr),
        body: FocusDetector(
            onVisibilityGained: () {},
            onVisibilityLost: () {},
            child: Obx(
              () {
                if (kIsWeb) {
                  return Visibility(
                        visible: controller.paymentUrl.value.isNotEmpty,
                        child:
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(controller.paymentUrl.value))) {
                                await launchUrl(
                                  Uri.parse(controller.paymentUrl.value),
                                  mode: LaunchMode.externalApplication, // Opens in browser
                                );
                              } else {
                                print('Could not launch ${Uri.parse(controller.paymentUrl.value)}');
                              }
                              // await Get.toNamed(RouteConstants.rSenangPayResult);
                            },
                            child: const Text('Pay with SenangPay'),
                          ),
                        ),
                      );
                } else {
                  return Visibility(
                        visible: controller.mWebViewController.value != null,
                        child: WebViewWidget(
                            controller: controller.mWebViewController.value!));
                }
              },
            )));
  }
}

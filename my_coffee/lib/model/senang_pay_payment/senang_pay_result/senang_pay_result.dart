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
import '../../../routes/route_constants.dart';
import 'controller/senang_pay_result_controller.dart';

class SenangPayResult extends GetView<SenangPayResultController> {
  SenangPayResult({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SenangPayResultController());
    String url = Uri.base.toString();
    controller.getUrlValue(url);
    return Scaffold(
        appBar: AppBarsCommon.appBarBackPayment(
            title: sSenangPayPaymentResult.tr,
            isBackCall: true,
            onClick: () {
              Get.offAllNamed(RouteConstants.rDashboardScreen);
            }),
        body: FocusDetector(
            onVisibilityGained: () {
            },
            onVisibilityLost: () {},
            child: Obx(
              () {
                if (kIsWeb) {
                  return Visibility(
                    visible: controller.orderId.value.isNotEmpty,
                    child: Center(
                      child: Text('orderId :${controller.orderId.value}'),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )));
  }
}

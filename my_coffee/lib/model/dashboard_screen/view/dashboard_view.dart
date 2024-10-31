/*
 * Project      : my_coffee
 * File         : dashboard_navigation.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/custom_image.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../login_screen/controller/login_controller.dart';
import '../controller/dashboard_controller.dart';

class DashboardViewScreen extends StatelessWidget {
  late DashboardScreenController controller;

  DashboardViewScreen({super.key}) {
    controller = Get.find<DashboardScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _fullView();
    });
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: controller.widgetOptions
                .elementAt(controller.selectedIndex.value)));
  }
}

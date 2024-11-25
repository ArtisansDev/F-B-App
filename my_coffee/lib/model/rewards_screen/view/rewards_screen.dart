import 'package:my_coffee/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../controller/rewards_controller.dart';

class RewardsScreen extends GetView<RewardsScreenController> {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RewardsScreenController());
    return _fullView();
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {
          Get.delete<RewardsScreenController>();
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                )));
  }

}

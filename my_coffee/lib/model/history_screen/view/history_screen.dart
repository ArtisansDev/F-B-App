import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../../../utils/app_utils.dart';
import '../controller/history_controller.dart';

class HistoryScreen extends GetView<HistoryScreenController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HistoryScreenController());
    return _fullView();
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {
          Get.delete<HistoryScreenController>();
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

import 'package:f_b_base/common/smart_footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/history_controller.dart';
import 'history_row.dart';

class HistoryScreen extends GetView<HistoryScreenController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HistoryScreenController());
    return FocusDetector(
        onVisibilityGained: () {
          if (controller.bFlagLoad.value) {
            controller.onRefresh();
          }else{
            controller.bFlagLoad.value = true;
          }
        },
        onVisibilityLost: () {},
        child: Obx(
          () {
            return Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: controller.enablePullUp.value,
                    header: const WaterDropHeader(),
                    footer: getCustomFooter(),
                    controller: controller.refreshController,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoadMore,
                    child: SingleChildScrollView(
                      child: controller.showValue.isNotEmpty
                          ? Container(
                              height: 75.h,
                              alignment: Alignment.center,
                              child: Text(controller.showValue.value),
                            )
                          : Column(
                              children: [
                                historyListView(),
                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            ),
                    )));
          },
        ));
  }

  /// History list
  historyListView() {
    return controller.mOrderHistoryResponseItemData.isEmpty
        ? Container(
            height: 80.h,
            alignment: Alignment.center,
            child: const Text('You don\'t have any history'),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: controller.mOrderHistoryResponseItemData.length,
            itemBuilder: (BuildContext context, int index) {
              return HistoryRow(
                index: index,
              );
            });
  }
}

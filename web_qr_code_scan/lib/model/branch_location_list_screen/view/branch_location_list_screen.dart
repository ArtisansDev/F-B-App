import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/common/smart_footer.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/branch_location_list_controller.dart';
import 'branch_location_list_row.dart';
import 'branch_location_list_search.dart';

class BranchLocationListScreen extends GetView<BranchLocationListController> {
  const BranchLocationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BranchLocationListController());
    return Scaffold(
        appBar: AppBarsCommon.appBarLocation(title: 'Branch List'),
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: _fullView(),
          bottom: false,
        ));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {

        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Opacity(
                    opacity: 0.5, // Set opacity here
                    child: Image.asset(
                    ImageAssetsConstants.buttonLogo,
                    width: 40.w,
                    fit: BoxFit.contain,
                  ),)
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: detailsView(),
                )
              ],
            )));
  }

  detailsView() {
    return Obx(
      () {
        return Container(
          margin: EdgeInsets.all(15.5.sp),
          child: Column(
            children: [
              BranchLocationListSearch(),
              Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: controller.enablePullUp.value,
                      header: const WaterDropHeader(),
                      footer: getCustomFooter(),
                      controller: controller.refreshController,
                      onRefresh: controller.onRefresh,
                      onLoading: controller.onLoadMore,
                      child: controller.mGetAllBranchesListData.isEmpty
                          ? const Center(
                              child: Text('No data found'),
                            )
                          : ListView.builder(
                              itemCount: controller
                                  .mGetAllBranchesListData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BranchLocationListRow(
                                  index: index,
                                );
                              },
                            )))
            ],
          ),
        );
      },
    );
  }
}

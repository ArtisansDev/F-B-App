import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/common/create_card_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../common/appbars_common.dart';
import '../../../common/button_constants.dart';
import '../../../common/custom_image.dart';
import '../../../common/smart_footer.dart';
import '../../../common/text_input_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/pattern_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/app_utils.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../controller/location_list_controller.dart';
import 'location_list_row.dart';
import 'location_list_search.dart';

class LocationListScreen extends GetView<LocationListScreenController> {
  const LocationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LocationListScreenController());
    return Scaffold(
        appBar: AppBarsCommon.appBarLocation(title: 'Outlet in your territory'),
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
                  // child: Image.asset(
                  //   ImageAssetsConstants.buttonLogo,
                  //   width: 40.w,
                  //   fit: BoxFit.contain,
                  // ),
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
              LocationListSearch(),
              Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: controller.enablePullUp.value,
                      header: const WaterDropHeader(),
                      footer: getCustomFooter(),
                      controller: controller.refreshController,
                      onRefresh: controller.onRefresh,
                      onLoading: controller.onLoadMore,
                      child: controller.mGetAllBranchesListData.value.isEmpty
                          ? const Center(
                              child: Text('No data found'),
                            )
                          : ListView.builder(
                              itemCount: controller
                                  .mGetAllBranchesListData.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LocationListRow(
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

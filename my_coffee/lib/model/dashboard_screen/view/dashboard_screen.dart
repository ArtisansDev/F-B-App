import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_coffee/constants/image_assets_constants.dart';
import 'package:my_coffee/model/dashboard_screen/view/dashboard_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/appbars_common.dart';
import '../controller/dashboard_controller.dart';
import 'dashboard_navigation.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardScreenController());
    return Scaffold(
      appBar: showAppBar(),
      body: SafeArea(
          bottom: false,
          child:  Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    ImageAssetsConstants.buttonLogo,
                    width: 40.w,
                    fit: BoxFit.contain,
                  ),
                ),
                DashboardViewScreen(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DashboardNavigationScreen(),
                )
              ],
            )
          ),
      // bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  ///appbar
  showAppBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(40.sp),
        child: Obx(
          () {
            return AppBarsCommon.appBarNotification(
                title: controller.sTitle.value,
                onClick: (value) {
                  if (value == 'notification') {}
                });
          },
        ));
  }
}

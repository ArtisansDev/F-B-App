/*
 * Project      : skill_360
 * File         : logout.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-08-16
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:get/get.dart';
import '../data/local/shared_prefs/shared_prefs.dart';
import '../model/dashboard_screen/controller/dashboard_controller.dart';
import '../routes/route_constants.dart';

logout() async {
  await clearToken();
  if (Get.isRegistered<DashboardScreenController>()) {
    DashboardScreenController mDashboardScreenController =
        Get.find<DashboardScreenController>();
    mDashboardScreenController.selectedIndex.value = 0;
    mDashboardScreenController.selectTitle(0);
  }
}

clearToken() async {
  await SharedPrefs().setUserToken('');
  await SharedPrefs().setUserDetails('');
  await SharedPrefs().setUserId('');
}

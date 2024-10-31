import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_coffee/model/menu_screen/side_menu/side_menu_row.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../controller/menu_controller.dart';

class SideMenuListScreen extends StatelessWidget {
  late MenuScreenController controller;

  SideMenuListScreen({super.key}) {
    controller = Get.find<MenuScreenController>();

  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: controller.itemScrollControllerMenu.value,
      scrollOffsetController:
      controller.scrollOffsetControllerMenu.value,
      itemPositionsListener:
      controller.itemPositionsListenerMenu.value,
      scrollOffsetListener: controller.scrollOffsetListenerMenu.value,
      itemCount: controller.mGetCategoryListData.value.length,
      itemBuilder: (BuildContext context, int index) {
        return SideMenuRow(index:index);
      },
    );
  }
}

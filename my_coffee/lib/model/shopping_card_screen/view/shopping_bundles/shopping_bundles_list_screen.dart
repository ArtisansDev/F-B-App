import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../controller/shoping_screen_controller.dart';
import 'shopping_bundles_row.dart';

class ShoppingBundlesListScreen extends StatelessWidget {
  late ShoppingScreenController controller;

  ShoppingBundlesListScreen({super.key}) {
    controller = Get.find<ShoppingScreenController>();

  }

  @override
  Widget build(BuildContext context) {
    return controller.mShoppingBundlesListCount.value != 0
        ? MediaQuery.removePadding(
      context: Get.context!,
      removeTop: true,
      removeBottom: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 36.h,
        ),
        itemCount: controller.mShoppingBundlesListCount.value,
        itemBuilder: (BuildContext context, int index) {
          return ShoppingBundlesRow(
            index: index,
          );
        },
      ),
    )
        : Center(
      child: Text(
        'No Recommended Course',
        style: getText500(
          colors: Colors.black,
          size: 16.sp,
        ),
      ),
    );
  }
}

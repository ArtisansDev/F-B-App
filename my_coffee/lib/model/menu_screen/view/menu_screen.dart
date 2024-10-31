import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../common/custom_image.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../utils/app_utils.dart';
import '../../details_page/controller/details_page_controller.dart';
import '../../order_confirmation/controller/order_confirmation_controller.dart';
import '../controller/menu_controller.dart';
import '../item_menu/item_menu_list_screen.dart';
import '../middle_filter_view/middle_filter_view.dart';
import '../side_menu/side_menu_list_screen.dart';
import '../top_address_bar/top_address_bar.dart';

class MenuScreen extends GetView<MenuScreenController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MenuScreenController());
    return _fullView();
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          if (Get.isRegistered<DetailsPageScreenController>()) {
            Get.delete<DetailsPageScreenController>();
          }
          if (Get.isRegistered<OrderConfirmationScreenController>()) {
            Get.delete<OrderConfirmationScreenController>();
          }
        },
        onVisibilityLost: () {},
        child: GestureDetector(onTap: () {
          AppUtils.hideKeyboard(Get.context!);
        }, child: Obx(
          () {
            return Column(
              children: [
                ///Top address bar
                TopAddressBar(),

                // ///MiddleFilter
                // MiddleFilterView(),

                /// Menu view
                Expanded(
                    child: controller.mGetCategoryListData.value.isEmpty
                        ? const Center(
                            child: Text('No Category List Found'),
                          )
                        : Container(
                            margin: EdgeInsets.only(bottom: 9.5.h),
                            height: double.infinity,
                            width: double.infinity,
                            child: mMenuView(),
                          ))
              ],
            );
          },
        )));
  }

  /// Menu view
  mMenuView() {
    return Row(children: [
      ///SideMenuL
      Expanded(
          flex: 3,
          child:
              SizedBox(height: double.infinity, child: SideMenuListScreen())),
      Container(
        height: double.infinity,
        width: 5.sp,
        color: Colors.grey.shade300,
      ),

      ///Item list
      Expanded(
          flex: 10,
          child: SizedBox(
            height: double.infinity,
            child: ItemMenuListScreen(),
          )),
    ]);
  }
}
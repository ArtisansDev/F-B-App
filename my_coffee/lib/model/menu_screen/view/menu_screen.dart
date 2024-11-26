import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../details_page/controller/details_page_controller.dart';
import '../../order_confirmation/controller/order_confirmation_controller.dart';
import '../../order_now/order_now.dart';
import '../controller/menu_controller.dart';
import '../item_menu/item_menu_list_screen.dart';
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
          controller.getOrderDetails();
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
            return Stack(
              children: [
                Column(
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
                              )),
                    SizedBox(
                      height: (controller.mAddCartModel.value.mItems ?? [])
                              .isNotEmpty
                          ? 9.h
                          : 0.h,
                    )
                  ],
                ),
                Container(
                    height: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: Visibility(
                        visible: (controller.mAddCartModel.value.mItems ?? [])
                            .isNotEmpty,
                        child: OrderNow((controller.mAddCartModel.value))))
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

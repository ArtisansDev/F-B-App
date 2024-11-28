import 'package:f_b_base/common/appbars_common.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/model/view_order_history/view/payment_details/payment_details_history_view.dart';
import 'package:my_coffee/model/view_order_history/view/pick_up_at_view/pick_up_at_history_view.dart';
import 'package:my_coffee/model/view_order_history/view/special_remarks/special_remarks_history_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/view_order_history_controller.dart';
import 'bottom_bar_order_now/bottom_bar_order_now_history_view.dart';
import 'order_list/order_list_history_view.dart';

class OrderHistoryScreen
    extends GetView<ViewOrderHistoryController> {
  late AddCartModel mAddCartModel;
   OrderHistoryScreen({super.key}){
     mAddCartModel = Get.arguments ;
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ViewOrderHistoryController(mAddCartModel));
    return Scaffold(
        appBar: AppBarsCommon.appBarBack(title: sOrderHistory.tr),
        body: SafeArea(bottom: false, child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorConstants.primaryBackgroundColor,
                alignment: Alignment.center,
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
                    mOrderConfirmationView(),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomBarOrderNowHistoryView())
                  ],
                )
            )));
  }

  mOrderConfirmationView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///Pick Up at
          PickUpAtHistoryView(),

          ///Your Order
          OrderListHistoryView(),

          // ///Frequently Enjoyed With
          // FrequentlyEnjoyedWithView(),

          ///Special Remarks
          SpecialRemarksHistoryView(),

          ///Packaging
          // PackagingView(),

          ///Payment Method
          // PaymentMethodHistoryView(),

          ///Vouchers
          // AddVouchersView(),

          ///Payment Details
          PaymentDetailsHistoryView(),

          SizedBox(
            height: 13.h,
          )
        ],
      ),
    );
  }
}
